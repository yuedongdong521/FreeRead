//
//  BookCase.m
//  FreeRead
//
//  Created by lanou3g on 15/4/18.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "BookCase.h"
#import "BookCaseCell.h"

#import "ClassifyVC.h"
#import "SearchVC.h"
#import "RecommendVC.h"
#import "RankingVC.h"
#import "Book_Info_VC.h"

#import "SmallMakeUpData.h"
#import "DataBaseHandler.h"
#import "ReadVC.h"
#import "DirectoryData.h"



@interface BookCase ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain)UICollectionView *collectionV;
@property (nonatomic, retain)NSMutableArray *arr;
@property (nonatomic, retain)NSMutableArray *directoryArr;
@property (nonatomic, retain)UIButton *button;
@property (nonatomic, retain)UILongPressGestureRecognizer *longP;
@property (nonatomic, retain)SmallMakeUpData *small;

@end

@implementation BookCase



-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:YES];
   
    self.tabBarController.tabBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
     self.arr = [NSMutableArray array];
    [self requestData];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(nsnoAction:) name:@"刷新页面" object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
   
}
- (void)nsnoAction:(NSNotification *)info
{
   self.arr = [[DataBaseHandler shareInstance] selectAll];
    
    [self.collectionV reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"我的书架";
    self.navigationItem.titleView = title;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"书城" style:UIBarButtonItemStylePlain target:self action:@selector(action:)];
    
    UIImageView *backIV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backIV.userInteractionEnabled = YES;
    backIV.image = [UIImage imageNamed:@"shujia.png"];
    [self.view addSubview:backIV];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.button.frame = CGRectMake(10, HEIGHT / 3, WIDTH - 20, HEIGHT / 3);
    self.button.frame = self.view.bounds;
    [self.button setTitle:@"        暂时没有添加书籍,赶快前往书城添加吧!!!  〉" forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont systemFontOfSize:20];
    self.button.titleLabel.numberOfLines = 0;
    self.button.tintColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    self.button.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self.button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    self.button.hidden = YES;
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(WIDTH / 3 - 20, HEIGHT / 4);
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:flow];
    self.collectionV.backgroundColor = [UIColor clearColor];
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    [backIV addSubview:_collectionV];
    [self.collectionV registerClass:[BookCaseCell class] forCellWithReuseIdentifier:@"cell"];
}


- (void)action:(UIButton *)button
{

    ClassifyVC *class = [[ClassifyVC alloc] init];
    UINavigationController *classNavi = [[UINavigationController alloc] initWithRootViewController:class];
    classNavi.tabBarItem.image = [UIImage imageNamed:@"fenlei.png"];
    classNavi.tabBarItem.title = @"分类";

    
    SearchVC *search = [[SearchVC alloc] init];
    search.title = @"搜索";
    UINavigationController *searchN = [[UINavigationController alloc] initWithRootViewController:search];
    searchN.tabBarItem.image = [UIImage imageNamed:@"sousuo.png"];
    
    RecommendVC *recommend = [[RecommendVC alloc] init];
    recommend.title = @"推荐";
    UINavigationController *recommendN = [[UINavigationController alloc] initWithRootViewController:recommend];
    recommend.tabBarItem.image = [UIImage imageNamed:@"hot.png"];
    
    RankingVC *ranking = [[RankingVC alloc] init];
    ranking.title = @"排行";
    UINavigationController *rankN = [[UINavigationController alloc] initWithRootViewController:ranking];
    ranking.tabBarItem.image = [UIImage imageNamed:@"shuzhuangtu.png"];
    
    self.tabBarController.tabBar.tintColor =  [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    self.tabBarController.viewControllers = @[recommendN, classNavi, rankN, searchN];

   
    
}


- (void)requestData
{
    [[DataBaseHandler shareInstance] openDB];
    [[DataBaseHandler shareInstance] createTable];
    NSMutableArray *arr = [[DataBaseHandler shareInstance] selectAll];
    
    if (arr.count != 0) {
         for (NSInteger i = arr.count - 1; i >= 0; i--) {
             [self.arr addObject:[arr objectAtIndex:i]];
         }
    
         [self.collectionV reloadData];
    } else {
        self.button.hidden = NO;
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookCaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.small = [self.arr objectAtIndex:indexPath.item];
    cell.tag = indexPath.item;
    self.longP = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPAction:)];
    self.longP.minimumPressDuration = 1;
    [cell addGestureRecognizer:self.longP];
    return cell;
}
- (void)longPAction:(UILongPressGestureRecognizer *)longP
{
    self.small = [self.arr objectAtIndex:longP.view.tag];
    if (longP.state == UIGestureRecognizerStateBegan) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定要移除书架吗?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[DataBaseHandler shareInstance] deleteSmall:self.small];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"刷新页面" object:nil];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReadVC *read = [[ReadVC alloc] init];
    read.bookUrl = [[self.arr objectAtIndex:indexPath.item] dirctStr];
    read.book_bool = YES;
    read._id = [[self.arr objectAtIndex:indexPath.item] _id];
    read.book_title = [[self.arr objectAtIndex:indexPath.item] title];
    NSLog(@"pppppppppp%@", [[self.arr objectAtIndex:indexPath.item] title]);
    read.content = 2;
    [self.navigationController pushViewController:read animated:YES];
}
//
//- (NSMutableArray *)requestDirctStr:(NSString *)dirctStr
//{
//    
//    NSMutableArray *arr = [NSMutableArray array];
//    dirctStr = [dirctStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//      NSLog(@"!!!!!!!!!!!%@", dirctStr);
//    NSURL *url = [NSURL URLWithString:dirctStr];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
//    request.HTTPMethod = @"GET";
//    
//    NSURLResponse *response = nil;
//    NSError *error = nil;
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    NSLog(@"+++++++++++++++%@", data);
//    
//    
//    
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    // 这里使用一个NSObject的方法-(NSUInteger)hash;获取一个字符串的哈希值, 当两个字符串完全一致的时候, 返回的哈希值是完全一样的, 每当有一点不同哈希值就完全不同.
//    // 哈希值和MD5一样, 过程是不可逆的, 但是都可以产生同样的字符串返回的值是一样的结果.
//    NSString *path = [NSString stringWithFormat:@"%@/%ld.aa", docPath, [dirctStr hash]];
//    
//    if (data != nil) {
//        // 当返回的数据不是空, 就调用block.
//        
//        BOOL result = [NSKeyedArchiver archiveRootObject:data toFile:path];
//        NSLog(@"存储成功: %d", result);
//        
//        NSLog(@"%@", path);
//       
//        id requestData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSArray *dircArr = [[requestData objectForKey:@"mixToc"] objectForKey:@"chapters"];
//     
//        for (NSDictionary *dic in dircArr) {
//            DirectoryData *data = [[DirectoryData alloc] initWithDictionary:dic];
//            [arr addObject:data];
//        }
//
//        
//    } else {
//        
//        // 没有网络/请求失败 就从本地读取最近的一次成功数据
//        NSData *pickData = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        if (pickData != nil) {
//            // 确保有数据才返回.
//            id requestData = [NSJSONSerialization JSONObjectWithData:pickData options:NSJSONReadingMutableContainers error:nil];
//            NSArray *dircArr = [[requestData objectForKey:@"mixToc"] objectForKey:@"chapters"];
//            for (NSDictionary *dic in dircArr) {
//                DirectoryData *data = [[DirectoryData alloc] initWithDictionary:dic];
//                [arr addObject:data];
//            }
//
//        }
//    }
//
//    NSLog(@"-----------------%@", arr);
//    return arr;
//}
//
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
