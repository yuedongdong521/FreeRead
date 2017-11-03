//
//  RecommendVC.m
//  FreeRead
//
//  Created by lanou3g on 15/4/18.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "RecommendVC.h"
#import "BookCase.h"
#import "RecommendCell.h"
#import "RecommendCRV.h"
#import "Book_Info_VC.h"
#import "More_BookVC.h"

#import "SmallMakeUpData.h"

@interface RecommendVC ()<UICollectionViewDataSource, UICollectionViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, retain)UIScrollView *scrollView;
@property (nonatomic, retain)UISegmentedControl *seg;
@property (nonatomic, retain)UICollectionView *collection;

@property (nonatomic, retain)NSArray *boyArr;
@property (nonatomic, retain)NSArray *girlArr;

@property (nonatomic, retain)NSMutableArray *smallArr;
@property (nonatomic, retain)NSMutableArray *nBookArr;
@property (nonatomic, retain)NSMutableArray *endArr;
@property (nonatomic, retain)NSMutableArray *recommendArr;
@property (nonatomic, assign)NSInteger segValue;

@property (nonatomic, retain)NSArray *actionArr;

@property (nonatomic, retain)MBProgressHUD *HUD;

@property (nonatomic, retain)UILabel *tishiLabel;
@property (nonatomic, retain)UIImageView *backImage;
@end

@implementation RecommendVC

- (void)viewWillAppear:(BOOL)animated
{
   self.tabBarController.tabBar.hidden = NO;
}

#pragma mark 网络请求
- (void)requestData
{
    // 小编推荐
    NSString *bSmallStr = @"http://api.zhuishushenqi.com/ranking/54d42dee5f3c22ae137255a0";
    NSString *bNStr = @"http://api.zhuishushenqi.com/ranking/54d42e72d9de23382e6877fb";
    NSString *bEndStr = @"http://api.zhuishushenqi.com/ranking/54d42e20a8cb149d07282495";
    NSArray *boyStrArr = @[bSmallStr, bNStr, bEndStr];
    
    NSMutableArray *boyS = [NSMutableArray array];
    NSMutableArray *boyB = [NSMutableArray array];
    NSMutableArray *boyE = [NSMutableArray array];
    self.boyArr = @[boyS, boyB, boyE];
    
    self.smallArr = [NSMutableArray array];
    self.nBookArr = [NSMutableArray array];
    self.endArr = [NSMutableArray array];
    
    NSArray *bookArr = @[self.smallArr, self.nBookArr, self.endArr];
   
    
    for (NSInteger i = 0; i < boyStrArr.count; i++) {
        NSString *str = [boyStrArr objectAtIndex:i];
        
        [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
            
            if (data != nil) {
                
                NSError *error = nil;
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                
                NSArray *dataArr = [[result objectForKey:@"ranking"] objectForKey:@"books"];
                if (dataArr.count == 0) {
                    self.tishiLabel.hidden = NO;
                }
                
                for (NSDictionary *dic in dataArr) {
                    SmallMakeUpData *data = [[SmallMakeUpData alloc] initWithDictionary:dic];
                    [[self.boyArr objectAtIndex:i] addObject:data];
                    [[bookArr objectAtIndex:i] addObject:data];
                }
                if (i == boyStrArr.count - 1) {
                    self.seg.hidden = NO;
                    self.collection.hidden = NO;
                    self.HUD.hidden = YES;
                    
                }
                
                [self.collection reloadData];
            } else {
                self.HUD.hidden = YES;
                self.tishiLabel.hidden = NO;
            }
        }];
    }

    
  
    NSString *gSmallStr = @"http://api.zhuishushenqi.com/ranking/54d4362af9ff9a5e08e1df61";
    NSString *gNStr = @"http://api.zhuishushenqi.com/ranking/54d43709fd6ec9ae04184aa5";
    NSString *gEndStr = @"http://api.zhuishushenqi.com/ranking/54d43674a84f05f82eb3e806";

    NSArray *girlStrArr = @[gSmallStr, gNStr, gEndStr];
    
    NSMutableArray *girlS = [NSMutableArray array];
    NSMutableArray *girlB = [NSMutableArray array];
    NSMutableArray *girlE = [NSMutableArray array];
    
    self.girlArr = @[girlS, girlB, girlE];
    
    
    for (NSInteger i = 0; i < girlStrArr.count; i++) {
        NSString *str = [girlStrArr objectAtIndex:i];
       
        
        [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
            
            if (data != nil) {
                NSError *error = nil;
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
                NSArray *dataArr = [[result objectForKey:@"ranking"] objectForKey:@"books"];
                
                for (NSDictionary *dic in dataArr) {
                    SmallMakeUpData *data = [[SmallMakeUpData alloc] initWithDictionary:dic];
                    [[self.girlArr objectAtIndex:i] addObject:data];
                }
                [self.collection reloadData];
            } else {
                self.HUD.hidden = YES;
                self.tishiLabel.hidden = NO;
            }
       
      }];
   }

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"推荐";
    self.navigationItem.titleView = title;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"书架" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarAction:)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.backImage];
    [self.backImage addSubview:self.HUD];
    self.HUD.labelText = @"正在拼命加载中...";
    self.HUD.minShowTime = 5;
    self.HUD.activityIndicatorColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    self.HUD.progress = 0;
    self.HUD.labelColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    self.HUD.color = [UIColor clearColor];
    self.HUD.delegate = self;
    [self.HUD show:YES];
    [self.HUD showAnimated:YES whileExecutingBlock:^{
        [self requestData];
    } completionBlock:^{
      
        [self.HUD removeFromSuperview];
    }];
    
    self.segValue = 0;
    [self makeView];

    
    
}




#pragma mark 视图布局
- (void)makeView
{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.backImage addSubview:self.scrollView];
    
    self.seg = [[UISegmentedControl alloc] initWithItems:@[@"帅哥", @"美女"]];
    self.seg.frame = CGRectMake(WIDTH / 5, 0, WIDTH / 5 * 3, HEIGHT / 16);
    [self.seg addTarget:self action:@selector(segAction) forControlEvents:UIControlEventValueChanged];
    
    self.seg.tintColor =  [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    self.seg.selectedSegmentIndex = 0;
    [self.scrollView addSubview:self.seg];
    self.seg.hidden = YES;
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(WIDTH / 3 - 20, HEIGHT / 4);
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
    flow.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, HEIGHT / 16 + 10, WIDTH, (HEIGHT / 2 + 50) * 3) collectionViewLayout:flow];
    self.collection.backgroundColor = [UIColor clearColor];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    
    // 注册header
    [self.collection registerClass:[RecommendCRV class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

    self.recommendArr = [NSMutableArray arrayWithObjects:@"小编推荐", @"新书推荐", @"完本推荐", nil];
    
    [self.collection registerClass:[RecommendCell class] forCellWithReuseIdentifier:@"cell"];
    [self.scrollView addSubview:self.collection];
    
    self.collection.hidden = YES;
    
    self.scrollView.contentSize = CGSizeMake(0, self.collection.Y + self.collection.H + 64 + 49);
    
    UIButton *smallButton = [UIButton buttonWithType:UIButtonTypeSystem];
    smallButton.frame = CGRectMake(WIDTH / 6 * 5, 0, WIDTH / 6 - 10, 40);
    [smallButton setTitle:@"更多" forState:UIControlStateNormal];
    smallButton.tintColor = [UIColor blueColor];
    [smallButton addTarget:self action:@selector(moreSmallAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.collection addSubview:smallButton];
    
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeSystem];
    newButton.frame = CGRectMake(WIDTH / 6 * 5, HEIGHT / 2 + 50, WIDTH / 6 - 10, 40);
    [newButton setTitle:@"更多" forState:UIControlStateNormal];
    newButton.tintColor = [UIColor blueColor];
    [newButton addTarget:self action:@selector(moreNewAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.collection addSubview:newButton];
    
    
    UIButton *endButton = [UIButton buttonWithType:UIButtonTypeSystem];
    endButton.frame = CGRectMake(WIDTH / 6 * 5, HEIGHT + 100, WIDTH / 6 - 10, 40);
    [endButton setTitle:@"更多" forState:UIControlStateNormal];
    endButton.tintColor = [UIColor blueColor];
    [endButton addTarget:self action:@selector(moreEndAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.collection addSubview:endButton];
    
}



- (void)segAction
{
    if (self.seg.selectedSegmentIndex == 0) {
        self.smallArr = [self.boyArr objectAtIndex:0];
        self.nBookArr = [self.boyArr objectAtIndex:1];
        self.endArr = [self.boyArr objectAtIndex:2];
        [self.collection reloadData];
    } else {
        self.smallArr = [self.girlArr objectAtIndex:0];
        self.nBookArr = [self.girlArr objectAtIndex:1];
        self.endArr = [self.girlArr objectAtIndex:2];
        [self.collection reloadData];
    }

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0 && self.smallArr.count != 0) {
         return 6;
    } else if (section == 1 && self.nBookArr.count != 0) {
         return 6;
    } else if (section == 2 && self.endArr.count != 0){
         return 6;
    } else {
         return 0;
    }

    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.data = [self.smallArr objectAtIndex:indexPath.item];
    } else if (indexPath.section == 1) {
        cell.data = [self.nBookArr objectAtIndex:indexPath.item];
    } else {
        cell.data = [self.endArr objectAtIndex:indexPath.item];
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Book_Info_VC *BIVC = [[Book_Info_VC alloc] init];
    if (indexPath.section == 0) {
        BIVC.book_id = [[self.smallArr objectAtIndex:indexPath.item] _id];
    } else if (indexPath.section == 1) {
        BIVC.book_id = [[self.nBookArr objectAtIndex:indexPath.item] _id];
    } else {
        BIVC.book_id = [[self.endArr objectAtIndex:indexPath.item] _id];
    }
    BIVC.makeV_bool = YES;
    [self.navigationController pushViewController:BIVC animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}



#pragma mark 设置collectionView header的高度
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(WIDTH, 30);
}

#pragma mark 设置collectionView header的值
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    RecommendCRV *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    header.title = [self.recommendArr objectAtIndex:indexPath.section];
    
    return header;
}

- (void)moreSmallAction:(UIButton *)button
{
    More_BookVC *book = [[More_BookVC alloc] init];
    book.arr = self.smallArr;
    [self.navigationController pushViewController:book animated:YES];
}

- (void)moreNewAction:(UIButton *)button
{
    More_BookVC *book = [[More_BookVC alloc] init];
    book.arr = self.nBookArr;
    [self.navigationController pushViewController:book animated:YES];
}

- (void)moreEndAction:(UIButton *)button
{
    More_BookVC *book = [[More_BookVC alloc] init];
    book.arr = self.endArr;
    [self.navigationController pushViewController:book animated:YES];
}

- (void)leftBarAction:(UIButton *)button
{
    BookCase *book = [[BookCase alloc] init];
    [self.navigationController pushViewController:book animated:YES];
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
