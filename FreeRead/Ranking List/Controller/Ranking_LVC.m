//
//  Ranking_LVC.m
//  FreeRead
//
//  Created by lanou3g on 15/4/23.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "Ranking_LVC.h"
#import "Ranking_List_Cell.h"
#import "SmallMakeUpData.h"
#import "Book_Info_VC.h"

@interface Ranking_LVC () <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>
@property (nonatomic, retain)UITableView *tabelView;
@property (nonatomic, retain)NSMutableArray *arr;
@property (nonatomic, retain)MBProgressHUD *HUD;
@property (nonatomic, retain)UILabel *tishiLabel;
@end

@implementation Ranking_LVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)requsetData
{
 
    NSString *str = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/ranking/%@", self.class_id];
    NSLog(@"%@", str);
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        
        if (data != nil) {

            NSError *error = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSArray *arr = [[result objectForKey:@"ranking"] objectForKey:@"books"];
            self.arr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                SmallMakeUpData *data = [[SmallMakeUpData alloc] initWithDictionary:dic];
                [self.arr addObject:data];
            }
            //        NSLog(@"+++++++++++++++++++%@", arr);
            [self makeView];
            self.HUD.hidden = YES;
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
    title.text = self.class_name;
    self.navigationItem.titleView = title;
    self.title = self.class_name;
    
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
