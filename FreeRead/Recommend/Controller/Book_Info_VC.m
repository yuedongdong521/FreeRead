//
//  Book_Info_VC.m
//  FreeRead
//
//  Created by lanou3g on 15/4/18.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "Book_Info_VC.h"
#import "RecommendCell.h"
#import "ReadVC.h"
#import "RecommendCRV.h"
#import "SmallMakeUpData.h"
#import "DirectoryData.h"
#import "DirectoryVC.h"
#import "DataBaseHandler.h"


@interface Book_Info_VC () <UICollectionViewDataSource, UICollectionViewDelegate, MBProgressHUDDelegate>
@property (nonatomic, retain)UIScrollView *scrollView;

@property (nonatomic, retain)UIImageView *imageV;
@property (nonatomic, retain)UILabel *titile;
@property (nonatomic, retain)UILabel *actour;
@property (nonatomic, retain)UILabel *type;
@property (nonatomic, retain)UILabel *state;
@property (nonatomic, retain)UITextView *infoText;
@property (nonatomic, retain)UILabel *label;

@property (nonatomic, retain)NSMutableArray *labelArray;
// 小说简介
@property (nonatomic, retain)NSString *str;
@property (nonatomic, assign)BOOL yes;

@property (nonatomic, retain)UIButton *dirctoryButton;
@property (nonatomic, retain)NSMutableArray *dirctArr;



@property (nonatomic, retain)SmallMakeUpData *book_data;

@property (nonatomic, retain)UICollectionView *collectionV;

@property (nonatomic, retain)NSMutableArray *arrA;

@property (nonatomic, retain)NSString *dirctStr;

@property (nonatomic, assign)BOOL flage;

@property (nonatomic, retain)SmallMakeUpData *small;

@property (nonatomic, retain)MBProgressHUD *HUD;
@property (nonatomic, retain)UILabel *tishiLabel;
@end

@implementation Book_Info_VC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
    if ([[DataBaseHandler shareInstance] sousuoWithID:self.book_id]) {
        self.navigationItem.rightBarButtonItem.title = @"已加入";
        self.flage = NO;
    } else {
        self.navigationItem.rightBarButtonItem.title = @"加入书架";
        self.flage = YES;
    }
    
}


- (void)requestData
{
    NSString *str = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/book/%@", self.book_id];

    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        
       if (data != nil) {
           
            NSError *error = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSDictionary *dic = result;
            self.book_data = [[SmallMakeUpData alloc] initWithDictionary:dic];
            NSLog(@"%@", str);
           
    #pragma mark 加载collection
            NSString *string = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/book/%@/recommend", self.book_id];
            NSLog(@"+++++++++++++==%@", string);
            [NetWorkHandle getDataWithUrl:string completion:^(NSData *data) {
                NSError *error = nil;
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                // 看过的人还在看
                NSArray *arrA = [result objectForKey:@"books"];
                self.arrA = [NSMutableArray array];
                for (NSDictionary *dic in arrA) {
                    SmallMakeUpData *data = [[SmallMakeUpData alloc] initWithDictionary:dic];
                    [self.arrA addObject:data];
                }
    #pragma mark 加载目录
                NSString *dircStr = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/mix-toc/%@", self.book_id];
                self.dirctStr = dircStr;
                [NetWorkHandle getDataWithUrl:dircStr completion:^(NSData *data) {
                    NSError *error = nil;
                    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                    NSArray *dircArr = [[result objectForKey:@"mixToc"] objectForKey:@"chapters"];
                    self.dirctArr = [NSMutableArray array];
                    for (NSDictionary *dic in dircArr) {
                        DirectoryData *data = [[DirectoryData alloc] initWithDictionary:dic];
                        [self.dirctArr addObject:data];
                    }
                    self.dirctoryButton.hidden = NO;
                    [self.collectionV reloadData];
                }];
                
                if (self.book_data != nil) {
                    if (self.makeV_bool) {
                        [self makeView];
                    }
                    [self height];
                    [self value];
                    self.HUD.hidden = YES;
                    
                } else {
                    NSLog(@"请求失败");
                    
                }
            }];
       } else {
           self.HUD.hidden = YES;
           self.tishiLabel.hidden = NO;
       }
     
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"小说详情";
    self.navigationItem.titleView = title;
    
    self.tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT / 4, WIDTH - 20, HEIGHT / 4)];
    self.tishiLabel.text = @"没有请求到数据,请检查网络...";
    self.tishiLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.tishiLabel];
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
         [self requestData];
    } completionBlock:^{
        
    }];

}




#pragma mark 创建视图
- (void)makeView
{
    self.small = [[SmallMakeUpData alloc] init];
    self.small.title = self.book_data.title;
    self.small.imageStr = self.book_data.imageStr;
    self.small.chaper = 0;
    self.small.page = 0;
    self.small.dirctStr = self.dirctStr;
    self.small._id = self.book_data._id;
    NSMutableArray *arr = [[DataBaseHandler shareInstance] selectAll];
    NSString *titleStr = [NSString string];
    self.flage = YES;
    if (arr.count == 0) {
        titleStr = @"加入书架";
    } else {
        for (SmallMakeUpData *data in arr) {
            if ([data._id isEqualToString:self.small._id]) {
                titleStr = @"已加入";
                self.flage = NO;
                break;
            }else {
                titleStr = @"加入书架";
                self.flage = YES;
            }
        }
        
    }
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:titleStr style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction:)];
    
    

    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, WIDTH / 3, HEIGHT / 4)];
  
    [self.scrollView addSubview:_imageV];
    
    NSMutableArray *labelArr = [NSMutableArray arrayWithObjects:@"书名:", @"作者:", @"类型:", @"描述:", nil];
    
    
    self.labelArray = [NSMutableArray array];
    // 创建label
    for (NSInteger i = 0; i < 4; i++) {
        UILabel *labelA = [self labelWithFrame:CGRectMake(self.imageV.frame.size.width + 20, 10 + HEIGHT / 16 * i, WIDTH / 4 - 10, HEIGHT / 16) text:[labelArr objectAtIndex:i]];
        UILabel *labelB = [[UILabel alloc] initWithFrame:CGRectMake(self.imageV.frame.size.width + WIDTH / 4 + 10, 10 + HEIGHT / 16 * i, WIDTH / 3, HEIGHT / 16)];
        [self.labelArray addObject:labelB];
        [self.scrollView addSubview:labelA];
        [self.scrollView addSubview:labelB];
    }
    
    self.label = [self labelWithFrame:CGRectMake(10, 10 + HEIGHT / 4, WIDTH / 3, HEIGHT / 16) text:@"小说简介"];
    self.label.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:self.label];
    
    UIButton *readButton = [UIButton buttonWithType:UIButtonTypeSystem];
    readButton.frame = CGRectMake(WIDTH / 8 * 5, 10 + HEIGHT / 4, WIDTH / 8 * 3 - 10, HEIGHT / 16);
    [readButton setImage:[UIImage imageNamed:@"yuedu.png"] forState:UIControlStateNormal];
    [readButton setTitle:@"开始阅读" forState:UIControlStateNormal];
    readButton.tintColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    readButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [readButton addTarget:self action:@selector(readButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:readButton];
    
    self.infoText = [[UITextView alloc] initWithFrame:CGRectMake(10, 10 + HEIGHT / 16 * 5, WIDTH - 20, HEIGHT / 8)];
    self.infoText.editable = NO;
    self.infoText.scrollEnabled = NO;
    self.infoText.backgroundColor = [UIColor whiteColor];
    self.infoText.font = [UIFont systemFontOfSize:14];
    self.infoText.textColor = [UIColor grayColor];
    self.infoText.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.infoText];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    self.yes = YES;
    [self.infoText addGestureRecognizer:tap];
    


    self.dirctoryButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.dirctoryButton.frame = CGRectMake(10, self.infoText.Y + self.infoText.H, WIDTH - 20, HEIGHT / 16);
    [self.dirctoryButton setImage:[UIImage imageNamed:@"mulu.png"] forState:UIControlStateNormal];
    [self.dirctoryButton setTitle:@"查看目录" forState:UIControlStateNormal];
    self.dirctoryButton.tintColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    self.dirctoryButton.backgroundColor = [UIColor whiteColor];
    self.dirctoryButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.dirctoryButton addTarget:self action:@selector(dirctoryAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.dirctoryButton];
    self.dirctoryButton.hidden = YES;
    
    
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(WIDTH / 3 - 20, HEIGHT / 5);
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;

    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(10, self.dirctoryButton.Y + self.dirctoryButton.H + 10, WIDTH - 20, HEIGHT / 5 + 40) collectionViewLayout:flow];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.scrollEnabled = NO;
    self.collectionV.backgroundColor = [UIColor whiteColor];
    [self.collectionV registerClass:[RecommendCRV class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.scrollView addSubview:self.collectionV];
    
    [self.collectionV registerClass:[RecommendCell class] forCellWithReuseIdentifier:@"cell"];
    
}


#pragma mark 重新计算高度
- (void)height
{
    NSLog(@"%ld++++++++++++", self.arrA.count);
    NSInteger m = 0;
    if (self.arrA.count % 3 == 0) {
        m = self.arrA.count / 3;
    } else {
        m = self.arrA.count / 3 + 1;
    }
    NSLog(@"========%ld=============%ld", m, self.arrA.count);
    self.collectionV.frame = CGRectMake(10, self.dirctoryButton.Y + self.dirctoryButton.H, WIDTH - 20, (HEIGHT / 5 + 10) * m + 40);
    
    self.scrollView.contentSize = CGSizeMake(0, self.collectionV.Y + self.collectionV.H);
}


#pragma mark 赋值
- (void)value
{
    [self.imageV setImageWithURLStr:self.book_data.imageStr Photo:@"backshu(1).png"];
    NSArray *arr = @[self.book_data.title, self.book_data.author, self.book_data.cat, self.book_data.tags_arr];
    
    for (NSInteger i = 0; i < self.labelArray.count; i++) {
        UILabel *label = [self.labelArray objectAtIndex:i];
        label.text = [arr objectAtIndex:i];
    }
    
    self.infoText.text = [@"      " stringByAppendingString:self.book_data.longIntro];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
        return self.arrA.count;
    
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
    header.title = @"书友推荐";
    
    return header;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   
    cell.data = [self.arrA objectAtIndex:indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.book_id = [[self.arrA objectAtIndex:indexPath.item] _id];
    self.makeV_bool = NO;
    self.HUD.hidden = NO;
    
    if ([[DataBaseHandler shareInstance] sousuoWithID:self.book_id]) {
        self.navigationItem.rightBarButtonItem.title = @"已加入";
        self.flage = NO;
    } else {
        self.navigationItem.rightBarButtonItem.title = @"加入书架";
        self.flage = YES;
    }
    
    [self.HUD showAnimated:YES whileExecutingBlock:^{
         [self requestData];
    } completionBlock:^{
        
    }];
}


#pragma mark 查看目录
- (void)dirctoryAction:(UIButton *)button
{
    DirectoryVC *direct = [[DirectoryVC alloc] init];
    direct.arr = self.dirctArr;
    direct.page = 0;
    direct.dirctStr = self.dirctStr;
    direct.book_id = self.book_id;
    direct.imageStr = self.book_data.imageStr;
    direct.name = self.book_data.title;
    
    [self.navigationController pushViewController:direct animated:YES];
    
}



#pragma mark 小说简介点击方法
- (void)tapAction
{
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect rect = [self.book_data.longIntro boundingRectWithSize:CGSizeMake(self.infoText.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
  
    if (self.yes && self.infoText.H < rect.size.height) {
        self.infoText.frame = CGRectMake(10, 10 + HEIGHT / 16 * 5, WIDTH - 20, rect.size.height);
        
        self.dirctoryButton.frame = CGRectMake(10, self.infoText.Y + self.infoText.H, WIDTH - 20, HEIGHT / 16);
        
        
        self.collectionV.frame = CGRectMake(10, self.dirctoryButton.Y + self.dirctoryButton.H, WIDTH - 20, (HEIGHT / 5 + 10) * 4 + 40);
        
        self.scrollView.contentSize = CGSizeMake(0, self.collectionV.Y + self.collectionV.H);
        
    } else {
         self.infoText.frame = CGRectMake(10, 10 + HEIGHT / 16 * 5, WIDTH - 20, HEIGHT / 8);
        self.dirctoryButton.frame = CGRectMake(10, self.infoText.Y + self.infoText.H, WIDTH - 20, HEIGHT / 16);
    
        self.collectionV.frame = CGRectMake(10, self.dirctoryButton.Y + self.dirctoryButton.H, WIDTH - 20, (HEIGHT / 5 + 10) * 4 + 40);
        self.scrollView.contentSize = CGSizeMake(0, self.collectionV.Y + self.collectionV.H);
    }
    self.yes = !_yes;
   
}

#pragma mark 开始阅读
- (void)readButtonAction:(UIButton *)button
{
    ReadVC *read = [[ReadVC alloc] init];
    read.arr = self.dirctArr;
    read.urlInt = 0;
    read.bookUrl = self.dirctStr;
    read._id = self.book_id;
    read.imageStr = self.book_data.imageStr;
    read.offset = 0;
    read.book_title = self.book_data.title;
    
    [self.navigationController pushViewController:read animated:YES];
}

#pragma mark 创建label
- (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

#pragma mark 添加|删除方法
- (void)rightBarAction:(UIButton *)button
{

    if (self.flage) {
       [[DataBaseHandler shareInstance] insertSmal:self.small];
    
        self.navigationItem.rightBarButtonItem.title = @"已加入";
        self.flage = !self.flage;
    } else {
        [[DataBaseHandler shareInstance] deleteSmall:self.small];
        self.navigationItem.rightBarButtonItem.title = @"加入书架";
        self.flage = !self.flage;
    }
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
