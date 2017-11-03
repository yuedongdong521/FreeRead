//
//  ReadVC.m
//  FreeRead
//
//  Created by lanou3g on 15/4/23.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "ReadVC.h"
#import "Read_Cell.h"
#import "Read_Data.h"
#import "DirectoryData.h"
#import "DirectoryVC.h"
#import "SmallMakeUpData.h"
#import "DataBaseHandler.h"

@interface ReadVC () <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, retain)UIImageView *backImage;

@property (nonatomic, retain)UICollectionView *collectionView;
@property (nonatomic, retain)NSString *str;
@property (nonatomic, retain)Read_Data *data;

@property (nonatomic, retain)NSMutableArray *textArr;
// 章节
@property (nonatomic, retain)NSMutableArray *titleArr;
// 每章总页数
@property (nonatomic, retain)NSMutableArray *pageNumArr;
// 前一章的所有页数
@property (nonatomic, retain)NSMutableArray *pageArr;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)BOOL flage;

@property (nonatomic, assign)NSInteger temp;

@property (nonatomic, retain)DirectoryData *directData;

// 加载上一章时临时保存当前数据
@property (nonatomic, retain)NSMutableArray *tempArr;
@property (nonatomic, retain)NSMutableArray *tempTitle;
@property (nonatomic, retain)NSMutableArray *tempPage;
@property (nonatomic, retain)NSMutableArray *tempPageNum;

@property (nonatomic, retain)UIAlertView *alerV;

// 目录缓存路劲
@property (nonatomic, retain)NSString *dirctPath;


// 工具栏
@property (nonatomic, retain)UILabel *toolLabel;
@property (nonatomic, retain)UIButton *dirctButton;
@property (nonatomic, retain)UIButton *lightButton;
@property (nonatomic, retain)UIButton *addButton;
@property (nonatomic, retain)UIButton *fontButton;
@property (nonatomic, assign)NSInteger backTemp;

@property (nonatomic, retain)UIView *lightView;

@property (nonatomic, retain)UISlider *lightSlider;
@property (nonatomic, assign)BOOL light_Bool;

@property (nonatomic, retain)UITableView *dirctTableView;
@property (nonatomic, assign)BOOL tableV_bool;

@property (nonatomic, assign)CGFloat fontSize;
@property (nonatomic, assign)CGFloat tempSize;

@property (nonatomic, assign)BOOL font_bool;
// 章节数
@property (nonatomic, assign)NSInteger chaper;
// 当前页数
@property (nonatomic, assign)NSInteger page_num;
// 添加书签
@property (nonatomic, retain)UIAlertView *addAlertV;
@property (nonatomic, retain)SmallMakeUpData *small;

@property (nonatomic, retain)MBProgressHUD *HUD;

// 网络请求
@property (nonatomic, retain)NSDictionary *dic;
@property (nonatomic, assign)BOOL data_bool;

@property (nonatomic, retain)UILabel *label;


@property (nonatomic, retain)UILabel *fontSize_Laebl;

@property (nonatomic, retain)UIButton *increase;
@property (nonatomic, retain)UIButton *reduce;

@end

@implementation ReadVC

#pragma make 同步请求所有目录
- (NSMutableArray *)requestDirctStr:(NSString *)dirctStr
{
    NSMutableArray *arr = [NSMutableArray array];
    
        dirctStr = [dirctStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      
        NSURL *url = [NSURL URLWithString:dirctStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
        request.HTTPMethod = @"GET";
        
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        // 这里使用一个NSObject的方法-(NSUInteger)hash;获取一个字符串的哈希值, 当两个字符串完全一致的时候, 返回的哈希值是完全一样的, 每当有一点不同哈希值就完全不同.
        // 哈希值和MD5一样, 过程是不可逆的, 但是都可以产生同样的字符串返回的值是一样的结果.
        NSString *path = [NSString stringWithFormat:@"%@/%ld.aa", docPath, [dirctStr hash]];
        
        if (data != nil) {
            // 当返回的数据不是空, 就调用block.
            
            BOOL result = [NSKeyedArchiver archiveRootObject:data toFile:path];
            NSLog(@"存储成功: %d", result);
            
            NSLog(@"%@", path);
            id requestData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *dircArr = [[requestData objectForKey:@"mixToc"] objectForKey:@"chapters"];
            
            for (NSDictionary *dic in dircArr) {
                DirectoryData *data = [[DirectoryData alloc] initWithDictionary:dic];
                [arr addObject:data];
            }
            
            
        } else {
            
            // 没有网络/请求失败 就从本地读取最近的一次成功数据
            NSData *pickData = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有网络连接,请检查网络!!!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            
            if (pickData != nil) {
                // 确保有数据才返回.
                id requestData = [NSJSONSerialization JSONObjectWithData:pickData options:NSJSONReadingMutableContainers error:nil];
                NSArray *dircArr = [[requestData objectForKey:@"mixToc"] objectForKey:@"chapters"];
                for (NSDictionary *dic in dircArr) {
                    DirectoryData *data = [[DirectoryData alloc] initWithDictionary:dic];
                    [arr addObject:data];
                }
                
            } else {
                self.label.hidden = NO;
            }
        }
    
 
    return arr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    self.tabBarController.tabBar.translucent = YES;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = self.book_title;
    self.navigationItem.titleView = title;
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];

    self.fontSize = 17;
    self.tempSize = 14;
    
    // 创建数据库类
    
    self.small = [[SmallMakeUpData alloc] init];
    if ([[DataBaseHandler shareInstance] sousuoWithID:self._id]) {
        self.small = [[DataBaseHandler shareInstance] smallWithID:self._id];
        self.chaper = self.small.chaper;
        self.page_num = self.small.page;
        self.offset = self.small.page;
        self.urlInt = self.small.chaper;
    } else {
        _small._id = self._id;
        _small.imageStr = self.imageStr;
        _small.title = self.book_title;
        _small.dirctStr = self.bookUrl;
    }
    
    
    
    
    self.backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.backImage.image = [UIImage imageNamed:@"beijing.png"];
    self.backImage.userInteractionEnabled = YES;
    [self.view addSubview:self.backImage];
    self.backTemp = 0;
    
    self.label = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.label.text = @"无法加载数据";
    self.label.backgroundColor = [UIColor clearColor];
    self.label.userInteractionEnabled = YES;
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.backImage addSubview:_label];
    self.label.hidden = YES;
    
    [self makeView];
    self.HUD = [[MBProgressHUD alloc] initWithView:self.backImage];
    self.HUD.userInteractionEnabled = NO;
    self.HUD.backgroundColor = [UIColor clearColor];
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
        
        if (self.book_bool) {
            self.arr = [self requestDirctStr:self.bookUrl];
        }
        self.directData = [self.arr objectAtIndex:self.urlInt];
        self.textArr = [NSMutableArray array];
        self.titleArr = [NSMutableArray array];
        self.pageArr = [NSMutableArray array];
        self.pageNumArr = [NSMutableArray array];
        self.tempArr = [NSMutableArray array];
        self.tempTitle = [NSMutableArray array];
        self.tempPage = [NSMutableArray array];
        self.tempPageNum = [NSMutableArray array];
        self.temp = self.urlInt;
        [self requestData];
    } completionBlock:^{
     
        self.HUD.hidden = YES;
     
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    // 隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.tableV_bool == NO) {
        self.navigationController.navigationBar.hidden = NO;
        self.toolLabel.hidden = NO;
    } else {
        if (_flage == NO) {
            _flage = !_flage;
            self.navigationController.navigationBar.hidden = _flage;
            
            self.toolLabel.hidden = _flage;
            
        }

    }
    if (self.light_Bool == NO) {
        self.light_Bool = !self.light_Bool;
        self.lightView.hidden = self.light_Bool;
    }
    //    self.dirctTableView.hidden = YES;
    if (self.font_bool == NO) {
        self.font_bool = ! self.font_bool;
        self.fontSize_Laebl.hidden = YES;
      
    }
    
    
}



#pragma mark 加载下一章

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
   
        if (self.collectionView.contentOffset.x > WIDTH * (self.textArr.count - 1)) {

            self.urlInt++;
            self.chaper = self.urlInt;
         
            if (self.urlInt < self.arr.count) {
                self.directData = [self.arr objectAtIndex:self.urlInt];
                self.content = 1;

                
                self.tempArr = [NSMutableArray array];
                self.tempTitle = [NSMutableArray array];
                
                self.HUD.hidden = NO;
                self.HUD.minShowTime = 5;
                [self.HUD showAnimated:YES whileExecutingBlock:^{
                    [self requestData];
                    self.collectionView.scrollEnabled = NO;
                } completionBlock:^{
                    self.HUD.hidden = YES;
                    self.collectionView.scrollEnabled = YES;
                }];
   
            } else {
                self.alerV.title = @"已近是最后一页啦!!!";
                [self.alerV show];
            }
        }
    
        if (self.collectionView.contentOffset.x < 0) {
            
            if (self.temp > 0) {
                self.temp--;
                self.chaper = self.temp;
                self.content = 0;
                
                self.tempArr = self.textArr;
                self.tempTitle = self.titleArr;
                self.tempPage = self.pageArr;
                self.tempPageNum = self.pageNumArr;
                
                self.textArr = [NSMutableArray array];
                self.titleArr = [NSMutableArray array];
                self.pageNumArr = [NSMutableArray array];
                self.pageArr = [NSMutableArray array];
                
              
                self.directData = [self.arr objectAtIndex:self.temp];

                
                self.HUD.hidden = NO;
                self.HUD.minShowTime = 5;
                [self.HUD showAnimated:YES whileExecutingBlock:^{
                    NSLog(@"11111");
                    [self requestData];
                    self.collectionView.scrollEnabled = NO;
                } completionBlock:^{
                    NSLog(@"22222");
                    self.HUD.hidden = YES;
                    self.collectionView.scrollEnabled = YES;
                }];
                
            } else {
            
                self.alerV.title = @"已经是第一页啦!!!";
                [self.alerV show];
            }
        }
    
   
   
    
}

#pragma mark 加载数据
- (void)requestData
{
    NSString *str = [NSString stringWithFormat:@"http://chapter.zhuishushenqi.com/chapter/%@",[self.directData link]];
    NSLog(@"章节网址  %@", str);
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        if (data != nil) {
            NSError *error = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            self.dic = [result objectForKey:@"chapter"];
            self.data_bool = [result objectForKey:@"ok"];
            self.data = [[Read_Data alloc] initWithDictionary:self.dic];
            [self judgeData];
            self.HUD.hidden = YES;
            self.label.hidden = YES;
            self.collectionView.scrollEnabled = YES;
        } else {
            self.label.hidden = NO;
            self.HUD.hidden = NO;
        }
    }];
 
}

#pragma mark 请求结束后进行数据判断

- (void)judgeData
{
    if (self.dic != nil && self.data_bool) {
        [self Paging];
        
        if (self.content == 0) {
            self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x - WIDTH, self.collectionView.contentOffset.y);
        } else if (self.content == 1) {
            self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x + WIDTH, self.collectionView.contentOffset.y);
        } else if (self.content == 2) {
            
            self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x + WIDTH * self.offset, self.collectionView.contentOffset.y);
            
        } else if (self.content == 3) {
            self.collectionView.contentOffset = CGPointMake(0, self.collectionView.contentOffset.y);
        }
        
        [self.collectionView reloadData];
        
        
    } else {
                        self.label.text = @"暂无数据!!!";
        NSLog(@"1111111111111111");
    }

}


#pragma mark 分页方式
- (void)Paging
{

    NSInteger height = HEIGHT - 70;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize]};
    CGRect rect = [self.data.body_str boundingRectWithSize:CGSizeMake(WIDTH - 21, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
 
    if (rect.size.height < height) {
        
        self.page = 0;
        [self.textArr addObject:self.data.body_str];
        [self.titleArr addObject:self.data.title];
        [self.pageArr addObject:[NSNumber numberWithInteger:self.page]];
        [self.pageNumArr addObject:[NSNumber numberWithInteger:self.page]];
        
    } else {
        // 预先计算页数 page
        NSInteger adPage = rect.size.height / height + 1;
        
        // 文本长度
        NSUInteger TextLenght = [self.data.body_str length];
        
        // 每页的字符数
        NSInteger adPageText = TextLenght / adPage;
//        NSLog(@"777777777777%ld", adPage);
        // 遍历所有页面
        
       self.page = 0;
        
        for (NSUInteger location = 0; location < TextLenght;) {

            // ji临界点(尺寸刚刚超过itme尺寸时的文本串) location页数
            NSRange range = NSMakeRange(location, adPageText);
    
            NSString *pageText;
            CGRect pageTextRect;
            
            while (range.location + range.length < TextLenght) {
                // 第location页的文本
                pageText = [self.data.body_str substringWithRange:range];
            
//                NSLog(@"88888888888888888%d", i++);
                // 计算每页文本的高度
                pageTextRect = [pageText boundingRectWithSize:CGSizeMake(WIDTH - 21, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
                
                if (pageTextRect.size.height > height) {
                    break;
                } else {
                    range.length += adPageText;
                }
            }
            // 最后一页文本
            if (range.location + range.length >= TextLenght) {
                range.length = TextLenght - range.location;
            }
        
            // 一个个缩短字符串的长度，当缩短后的字符串尺寸小于itme的尺寸时即为满足
            while (range.length > 0) {
                pageText = [self.data.body_str substringWithRange:range];
                pageTextRect = [pageText boundingRectWithSize:CGSizeMake(WIDTH - 21, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
                if (pageTextRect.size.height <= height) {
                    range.length = [pageText length];
                    break;
                } else {
                    range.length -= 1;
                }
            }
         
            [self.titleArr addObject:self.data.title];
            [self.textArr addObject:[self.data.body_str substringWithRange:range]];
            [self.pageArr addObject:[NSNumber numberWithInteger:self.page]];
            self.page++;
            
#pragma mark 循环自增变量
            location += range.length;

        }
    }
    
    for (NSInteger i = 0; i < self.page; i++) {
        [self.pageNumArr addObject:[NSNumber numberWithInteger:self.page]];
    }
    for (NSInteger i = 0; i < self.tempArr.count; i++) {
        [self.textArr addObject:[self.tempArr objectAtIndex:i]];
        [self.titleArr addObject:[self.tempTitle objectAtIndex:i]];
        [self.pageArr addObject:[self.tempPage objectAtIndex:i]];
        [self.pageNumArr addObject:[self.tempPageNum objectAtIndex:i]];
    }

   
   
    
    
}

#pragma mark 创建视图
- (void)makeView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(WIDTH - 1, HEIGHT - 30);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
   
    flow.sectionInset = UIEdgeInsetsMake(10, 0.5, 10, 0.5);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 1, HEIGHT) collectionViewLayout:flow];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.backImage addSubview:self.collectionView];
    
    [self.collectionView registerClass:[Read_Cell class] forCellWithReuseIdentifier:@"cell"];
 
  
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    self.flage = YES;
    [self.collectionView addGestureRecognizer:tap];
    
    // 工具栏
    
    [self makeToolView];

    self.alerV = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [self.view addSubview:self.alerV];
    
    [self makeAddAlertView];
    
    [self makeDirectView];
    
    [self makeStepper];
    
    self.tableV_bool = YES;
    self.dirctTableView.hidden = self.tableV_bool;
}

#pragma mark 创建添加提示

- (void)makeAddAlertView
{
    self.addAlertV = [[UIAlertView alloc] initWithTitle:@"赶快加入书架吧!!!" message:nil delegate:self cancelButtonTitle:@"暂不添加" otherButtonTitles:@"添加", nil];
    [self.view addSubview:self.addAlertV];
}

#pragma mark 返回
- (void)leftAction:(UIButton *)button
{
 
    _small.chaper = self.chaper;
    _small.page = self.page_num;
    if ([[DataBaseHandler shareInstance] haveOrNo:_small]) {
        
        [[DataBaseHandler shareInstance] changeWithSmall:self.small];
      
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.addAlertV show];
    }
    
   
}

#pragma mark 添加
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.addAlertV) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[DataBaseHandler shareInstance] insertSmal:_small];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark 创建工具栏
- (void)makeToolView
{
    // 工具栏
    
    self.toolLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT / 10 * 9, WIDTH, HEIGHT / 10)];
    self.toolLabel.userInteractionEnabled = YES;
    [self.backImage addSubview:self.toolLabel];
    [self.view bringSubviewToFront:self.toolLabel];
    self.toolLabel.hidden = YES;
    
    
    self.dirctButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.dirctButton.frame = CGRectMake(0, 0, self.toolLabel.W / 4, HEIGHT / 10);
    [self.dirctButton setTitle:@"目录" forState:UIControlStateNormal];
    self.dirctButton.tintColor = [UIColor whiteColor];
    self.dirctButton.backgroundColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    [self.dirctButton addTarget:self action:@selector(dirctAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolLabel addSubview:self.dirctButton];
    
    self.lightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.lightButton.tintColor = [UIColor whiteColor];
    self.lightButton.backgroundColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    self.lightButton.frame = CGRectMake(self.toolLabel.W / 4, 0, self.toolLabel.W / 4, HEIGHT / 10);
    [self.lightButton setTitle:@"亮度" forState:UIControlStateNormal];
    [self.lightButton addTarget:self action:@selector(lightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolLabel addSubview:self.lightButton];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.addButton.tintColor = [UIColor whiteColor];
    self.addButton.backgroundColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    
    self.addButton.frame = CGRectMake(self.toolLabel.W / 2, 0, self.toolLabel.W / 4, HEIGHT / 10);
    [self.addButton setTitle:@"护眼" forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolLabel addSubview:self.addButton];
    
    self.fontButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.fontButton.tintColor = [UIColor whiteColor];
    self.fontButton.backgroundColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    self.fontButton.frame = CGRectMake(self.toolLabel.W / 4 * 3, 0, self.toolLabel.W / 4, HEIGHT / 10);
    [self.fontButton setTitle:@"字体" forState:UIControlStateNormal];
    [self.fontButton addTarget:self action:@selector(fontAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolLabel addSubview:self.fontButton];
    
#pragma mark 调整屏幕亮度
    self.lightView = [[UIView alloc]initWithFrame:CGRectMake(10, HEIGHT / 5 * 4, WIDTH - 20, HEIGHT / 12)];
    _lightView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_lightView];
    self.lightSlider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, WIDTH - 20, HEIGHT / 12)];
    _lightSlider.minimumValueImage = [UIImage imageNamed:@"light_small"];
    _lightSlider.maximumValueImage = [UIImage imageNamed:@"light_large"];
    [_lightSlider addTarget:self action:@selector(lightSliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [_lightView addSubview:_lightSlider];
    self.light_Bool = YES;
    self.lightView.hidden = self.light_Bool;
    
}


#pragma mark 创建Stepper
- (void)makeStepper
{
    self.fontSize_Laebl = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 6, HEIGHT / 5 * 4, WIDTH / 6 * 4, HEIGHT / 12)];
    self.fontSize_Laebl.userInteractionEnabled = YES;
    self.fontSize_Laebl.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    self.fontSize_Laebl.textAlignment = NSTextAlignmentCenter;
    self.fontSize_Laebl.tintColor = [UIColor whiteColor];
    self.fontSize_Laebl.textColor = [UIColor whiteColor];
    self.fontSize_Laebl.text = [NSString stringWithFormat:@"%.f", self.fontSize];
    [self.backImage addSubview:self.fontSize_Laebl];
    self.fontSize_Laebl.hidden = YES;
    
    self.increase = [UIButton buttonWithType:UIButtonTypeSystem];
    self.increase.frame = CGRectMake(WIDTH / 6 * 3, 0, WIDTH / 6, HEIGHT / 12);
    [self.increase setImage:[UIImage imageNamed:@"jia.png"] forState:UIControlStateNormal];
    [self.increase addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.fontSize_Laebl addSubview:self.increase];
    
    self.reduce = [UIButton buttonWithType:UIButtonTypeSystem];
    self.reduce.frame = CGRectMake(0, 0, WIDTH / 6, HEIGHT / 12);
    [self.reduce setImage:[UIImage imageNamed:@"jian.png"] forState:UIControlStateNormal];
    [self.reduce addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.fontSize_Laebl addSubview:self.reduce];
    self.font_bool = YES;
    
}

#pragma mark 改变字体大小
- (void)buttonAction:(UIButton *)button
{
    if (self.fontSize > 13 && self.fontSize < 25) {
        if (button == self.increase) {
            self.fontSize++;
        } else {
            self.fontSize--;
        }
        self.fontSize_Laebl.text = [NSString stringWithFormat:@"%.f", self.fontSize];
        self.textArr = [NSMutableArray array];
        self.titleArr = [NSMutableArray array];
        self.pageArr = [NSMutableArray array];
        self.pageNumArr = [NSMutableArray array];
        self.temp = self.chaper;
        self.urlInt = self.chaper;
        [self Paging];
        [self.collectionView reloadData];
    }
}

#pragma marke 创建目录列表
- (void)makeDirectView
{
    self.dirctTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HEIGHT / 10, WIDTH / 3 * 2, HEIGHT / 10 * 8) style:UITableViewStylePlain];
    self.dirctTableView.delegate = self;
    self.dirctTableView.dataSource = self;
    [self.backImage addSubview:self.dirctTableView];
    [self.dirctTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.dirctTableView.contentOffset = CGPointMake(0, HEIGHT / 12 * self.temp);
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT / 12;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    DirectoryData *data = [[DirectoryData alloc] init];
    
    data = [self.arr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [@"     " stringByAppendingString:data.title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.directData = [self.arr objectAtIndex:indexPath.row];
    self.tableV_bool = !self.tableV_bool;
    self.dirctTableView.hidden = self.tableV_bool;
    self.navigationController.navigationBar.hidden = YES;
    self.toolLabel.hidden = YES;
    self.textArr = [NSMutableArray array];
    self.titleArr = [NSMutableArray array];
    self.pageArr = [NSMutableArray array];
    self.pageNumArr = [NSMutableArray array];
    
    // 重新复制
    self.content = 3;
    self.temp = indexPath.row;
    self.urlInt = indexPath.row;
    
    self.HUD.hidden = NO;
    self.HUD.minShowTime = 2;
    [self.HUD showAnimated:YES whileExecutingBlock:^{
        [self requestData];
        self.collectionView.scrollEnabled = NO;
    } completionBlock:^{
        self.HUD.hidden = YES;
        self.collectionView.scrollEnabled = YES;
    }];
    
}



#pragma mark 工具栏方法
#pragma mark 查看目录
- (void)dirctAction:(UIButton *)button
{
    self.tableV_bool = !self.tableV_bool;
    self.dirctTableView.contentOffset = CGPointMake(0, HEIGHT / 12 * self.temp);
    self.dirctTableView.hidden = self.tableV_bool;
    [self.dirctTableView reloadData];
    
}

// 调节亮度
- (void)lightAction:(UIButton *)button
{
    NSLog(@"11111111111");
    self.light_Bool = !self.light_Bool;
    self.lightView.hidden = self.light_Bool;
}


// 护眼
- (void)addAction:(UIButton *)button
{
    if (self.backTemp % 3 == 0) {
        self.backImage.image = [UIImage imageNamed:@"huyan.png"];
    } else if (self.backTemp % 3 == 1) {
        self.backImage.image = [UIImage imageNamed:@"zhengchang.png"];
    } else {
        self.backImage.image = [UIImage imageNamed:@"beijing.png"];
    }
    
    self.backTemp++;
}

- (void)fontAction:(UIButton *)button
{
    self.font_bool = !self.font_bool;
    self.fontSize_Laebl.hidden = self.font_bool;
   
}

- (void)lightSliderValueChange:(UISlider *)slider
{
    [[UIScreen mainScreen] setBrightness: slider.value];
}


#pragma mark 隐藏导航栏
- (void)tapAction
{
    if (self.light_Bool == NO) {
        self.light_Bool = !self.light_Bool;
        self.lightView.hidden = self.light_Bool;
    }
    
    if (self.tableV_bool == NO) {
        self.tableV_bool = !self.tableV_bool;
        self.dirctTableView.hidden = YES;
    }
    
   
    if (self.font_bool == NO) {
        self.font_bool = ! self.font_bool;
        self.fontSize_Laebl.hidden = YES;
    }
 
    
    _flage = !_flage;
    self.navigationController.navigationBar.hidden = _flage;
        
    self.toolLabel.hidden = _flage;
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.textArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    Read_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.name = [self.titleArr objectAtIndex:indexPath.item];
    cell.text = [self.textArr objectAtIndex:indexPath.item];
    self.page_num = [[self.pageArr objectAtIndex:indexPath.item] integerValue];
    if (self.textArr.count - 1 == indexPath.item) {
        cell.bodyHeight = [self bodyHeightWithText:[self.textArr objectAtIndex:indexPath.item]];
    }
    
    cell.num = [[NSString stringWithFormat:@"%ld",[[self.pageArr objectAtIndex:indexPath.item] integerValue] + 1] stringByAppendingString:[@"/" stringByAppendingString:[NSString stringWithFormat:@"%ld",[[self.pageNumArr objectAtIndex:indexPath.item] integerValue]]]];
    cell.fontSize = self.fontSize;
    return cell;
}

- (CGFloat)bodyHeightWithText:(NSString *)text
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(WIDTH - 21, HEIGHT - 80) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
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
