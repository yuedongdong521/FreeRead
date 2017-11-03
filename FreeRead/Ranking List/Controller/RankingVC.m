//
//  RankingVC.m
//  FreeRead
//
//  Created by lanou3g on 15/4/18.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "RankingVC.h"
#import "RankingCell.h"
#import "Ranking_LVC.h"
#import "SmallMakeUpData.h"

@interface RankingVC ()<UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *boyArr;
@property (nonatomic, retain) NSMutableArray *boy_id;
@property (nonatomic, retain) NSMutableArray *girlArr;
@property (nonatomic, retain) NSMutableArray *girl_id;
@property (nonatomic, retain) UISegmentedControl *sexSeg;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) UIImageView *backImage;
@property (nonatomic, retain) UILabel *tishiLabel;
@end

@implementation RankingVC




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"排行榜";
    self.navigationItem.titleView = title;
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
        [self.HUD removeFromSuperview];
    }];
    
}

- (void)requestData
{
    NSString *str = @"http://api.zhuishushenqi.com/ranking/gender";
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        
        if (data != nil) {
        
            NSError *error = nil;
            id resule = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSArray *arr = [resule objectForKey:@"male"];
            self.boyArr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                SmallMakeUpData *data = [[SmallMakeUpData alloc] initWithDictionary:dic];
                if (data.collapse) {
                   [self.boyArr addObject:data];
                }
            }
            
            NSArray *girlArr = [resule objectForKey:@"female"];
            self.girlArr = [NSMutableArray array];
            for (NSDictionary *dic in girlArr) {
                SmallMakeUpData *data = [[SmallMakeUpData alloc] initWithDictionary:dic];
                
                if ([data.title isEqualToString:@"晋江言情榜"] || [data.title isEqualToString:@"晋江耽美榜"] || [data.title isEqualToString:@"17K订阅榜"]) {
                    data.collapse = NO;
                }
                
                if (data.collapse) {
                    [self.girlArr addObject:data];
                }
                
            }
            [self makeView];
            self.HUD.hidden = YES;
            
        } else {
            self.HUD.hidden = YES;
            self.tishiLabel.hidden = NO;
        }
    }];
}



#pragma mark 布局
- (void)makeView
{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, WIDTH - 20, HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.backImage addSubview:self.tableView];
    
    [self.tableView registerClass:[RankingCell class] forCellReuseIdentifier:@"cell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT / 12;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"帅哥";
    } else {
        return @"美女";
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.boyArr.count;
    } else {
        return self.girlArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.title.text = [[self.boyArr objectAtIndex:indexPath.row] title];
    } else {
        cell.title.text = [[self.girlArr objectAtIndex:indexPath.row] title];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ranking_LVC *ranking = [[Ranking_LVC alloc] init];
    
    if (indexPath.section == 0) {
        ranking.class_id = [[self.boyArr objectAtIndex:indexPath.row] _id];
        ranking.class_name = [[self.boyArr objectAtIndex:indexPath.row] title];
    } else {
        ranking.class_id = [[self.girlArr objectAtIndex:indexPath.row] _id];
        ranking.class_name = [[self.girlArr objectAtIndex:indexPath.row] title];
    }

    [self.navigationController pushViewController:ranking animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
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
