//
//  ClassifyVC.m
//  FreeRead
//
//  Created by lanou3g on 15/4/18.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "ClassifyVC.h"
#import "ClassifyCRV.h"
#import "ClassifyCell.h"
#import "ClassData.h"
#import "Ranking_ListVC.h"


@interface ClassifyVC ()<UICollectionViewDataSource, UICollectionViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, retain) UICollectionView *collectionV;
@property (nonatomic, retain) NSMutableArray *boyArr;
@property (nonatomic, retain) NSMutableArray *girlArr;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) UIImageView *backImage;

@property (nonatomic, retain) UILabel *tishiLabel;

@end

@implementation ClassifyVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark 数据请求
- (void)requsetData
{
    NSString *str = @"http://api.zhuishushenqi.com/cats";
    
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        
        NSLog(@"          %@", data);
        if (data != nil) {
        
            NSError *error = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            NSArray *boyArr = [result objectForKey:@"male"];
            self.boyArr = [NSMutableArray array];
            for (NSDictionary *dic in boyArr) {
                ClassData *data = [[ClassData alloc] initWithDictionary:dic];
                [self.boyArr addObject:data];
            }
            
            NSArray *girlArr = [result objectForKey:@"female"];
            self.girlArr = [NSMutableArray array];
            for (NSDictionary *dic in girlArr) {
                ClassData *data = [[ClassData alloc] initWithDictionary:dic];
                if (![data.name isEqualToString:@"耽美"]) {
                   [self.girlArr addObject:data];
                }
            }
            self.HUD.hidden = YES;
            [self makeView];
        } else {
            self.HUD.hidden = YES;
            self.tishiLabel.hidden = NO;
        }
    }];
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    self.title = @"分类";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"分类";
    self.navigationItem.titleView = title;
    
    self.navigationController.navigationBar.translucent = NO;
   
    self.backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.backImage.userInteractionEnabled = YES;
    self.backImage.image = [UIImage imageNamed:@"shujia.png"];
    [self.view addSubview:self.backImage];

    
    self.tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT / 4, WIDTH - 20, HEIGHT / 4)];
    self.tishiLabel.text = @"没有请求到数据,请检查网络...";
    self.tishiLabel.textAlignment = NSTextAlignmentCenter;
    [self.backImage addSubview:self.tishiLabel];
    self.tishiLabel.hidden = YES;
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.labelText = @"正在拼命加载中...";
    self.HUD.minShowTime = 5;
    self.HUD.activityIndicatorColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    self.HUD.progress = 0;
    self.HUD.labelColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    self.HUD.color = [UIColor clearColor];
    self.HUD.delegate = self;
    [self.HUD show:YES];
    [self.HUD showAnimated:YES whileExecutingBlock:^{
        [self requsetData];
    } completionBlock:^{
        [self.HUD removeFromSuperview];
    }];

}

#pragma mark 布局
- (void)makeView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(WIDTH / 3 - 20, HEIGHT / 10);
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
    
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:flow];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.showsHorizontalScrollIndicator = NO;
    self.collectionV.showsVerticalScrollIndicator = NO;
    self.collectionV.backgroundColor = [UIColor clearColor];
    
    [self.collectionV registerClass:[ClassifyCRV class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.backImage addSubview:self.collectionV];
    
    [self.collectionV registerClass:[ClassifyCell class] forCellWithReuseIdentifier:@"cell"];
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.boyArr.count;
    } else {
        return self.girlArr.count;
    }
}


-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(WIDTH, 30);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ClassifyCRV *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        header.title.text = @"帅哥";
    } else {
        header.title.text = @"美女";
    }
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     ClassifyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.data = [self.boyArr objectAtIndex:indexPath.item];
    } else if (indexPath.section == 1) {
        cell.data = [self.girlArr objectAtIndex:indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Ranking_ListVC *rank = [[Ranking_ListVC alloc] init];
      rank.flag = 0;
    if (indexPath.section == 0) {
        rank.class_id = [[self.boyArr objectAtIndex:indexPath.item] name];
    } else {
        rank.class_id = [[self.girlArr objectAtIndex:indexPath.item] name];
    }
    [self.navigationController pushViewController:rank animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
