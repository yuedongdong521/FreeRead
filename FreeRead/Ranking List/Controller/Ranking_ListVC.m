//
//  Ranking_ListVC.m
//  FreeRead
//
//  Created by lanou3g on 15/4/21.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "Ranking_ListVC.h"
#import "Ranking_List_Cell.h"
#import "SmallMakeUpData.h"
#import "Book_Info_VC.h"
#import "MJRefresh.h"


@interface Ranking_ListVC () <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, retain)UITableView *tabelView;
@property (nonatomic, retain)NSMutableArray *arr;
@property (nonatomic, retain)UILabel *label;
@property (nonatomic, retain)MBProgressHUD *HUD;
@property (nonatomic, retain)UILabel *title_label;
@property (nonatomic, assign)NSInteger start;
@property (nonatomic, retain)UILabel *tishiLabel;
@end

@implementation Ranking_ListVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)requsetData
{
    NSString *str = [NSString string];
    if (self.flag == 0) {
        str = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/book/by-tag?tag=%@&start=0&limit=50", self.class_id];
        self.title_label.text = self.class_id;
        NSLog(@"%@1111111111", self.class_id);
        
    } else if (self.flag == 1) {
        str = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/ranking/%@", self.class_id];
        
         NSLog(@"%@222222222", self.class_id);
        
    } else if (self.flag == 2) {
        str = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/book/fuzzy-search?query=%@", self.class_id];
        
         NSLog(@"%@333333333", self.class_id);
    }
    NSLog(@"%ld++++++++\n++++++++++%@", self.flag, str);
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        
        if (data != nil) {
        
            NSError *error = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSArray *arr = [result objectForKey:@"books"];
            
            self.arr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                SmallMakeUpData *data = [[SmallMakeUpData alloc] initWithDictionary:dic];
                [self.arr addObject:data];
            }
    //        NSLog(@"+++++++++++++++++++%@", arr);
            [self makeView];
            self.HUD.hidden = YES;
            if (self.arr.count == 0 && self.flag == 2) {
                self.tabelView.hidden = YES;
                self.label.hidden = NO;
            }
            
            if (self.flag == 0) {
                [self.tabelView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestNewData)];
                 [self.tabelView.footer beginRefreshing];
            }
        } else {
            self.HUD.hidden = YES;
            self.tishiLabel.hidden = NO;
        }
        
        
    }];


}


- (void)requestNewData
{
    NSString *str = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/book/by-tag?tag=%@&start=%ld&limit=50", self.class_id, self.start++];
    NSLog(@"=========%@", str);
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *arr = [result objectForKey:@"books"];
        
//        if (arr.count == 0) {
//            [self.tabelView removeFooter];
//        }
        
        for (NSDictionary *dic in arr) {
            SmallMakeUpData *data = [[SmallMakeUpData alloc] initWithDictionary:dic];
            [self.arr addObject:data];
        }
        //        NSLog(@"+++++++++++++++++++%@", arr);
        [self.tabelView reloadData];
        [self.tabelView.footer endRefreshing];
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    self.title_label.textColor = [UIColor whiteColor];
    self.title_label.backgroundColor = [UIColor clearColor];
    self.title_label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = self.title_label;

    self.start = 1;
    NSLog(@"///////////////////////");
    
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
        [self requsetData];
    } completionBlock:^{
//        [self.HUD removeFromSuperview];
    }];


}

- (void)makeView
{
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.view addSubview:self.tabelView];
    
    [self.tabelView registerClass:[Ranking_List_Cell class] forCellReuseIdentifier:@"cell"];
    
    self.label = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.label.text = @"未找到您要搜索的内容";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
    self.label.hidden = YES;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT / 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.delaysContentTouches = NO;
    Ranking_List_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.data = [self.arr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Book_Info_VC *BIVC = [[Book_Info_VC alloc] init];
    BIVC.book_id = [[self.arr objectAtIndex:indexPath.row] _id];
    BIVC.makeV_bool = YES;
    [self.navigationController pushViewController:BIVC animated:YES];
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
