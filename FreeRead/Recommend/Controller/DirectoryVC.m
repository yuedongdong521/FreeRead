//
//  DirectoryVC.m
//  FreeRead
//
//  Created by lanou3g on 15/4/24.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "DirectoryVC.h"
#import "DirectoryData.h"
#import "ReadVC.h"


@interface DirectoryVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, assign)BOOL flage;
@end

@implementation DirectoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"倒序" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    self.flage = YES;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"目录";
    self.navigationItem.titleView = title;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.contentOffset = CGPointMake(0, HEIGHT / 12 * self.page);
    
}

- (void)rightBarAction
{
    NSArray *arr = [NSArray arrayWithArray:self.arr];
    self.arr = [NSMutableArray array];
    for (NSInteger i = arr.count - 1; i >= 0; i--) {
        [self.arr addObject:[arr objectAtIndex:i]];
    }
    if (self.flage) {
        self.navigationItem.rightBarButtonItem.title = @"正序";
    } else {
        self.navigationItem.rightBarButtonItem.title = @"倒序";
    }
    
    [self.tableView reloadData];
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
    ReadVC *read = [[ReadVC alloc] init];
    read.urlInt = indexPath.row;
    read.arr = self.arr;
    
    read.bookUrl = self.dirctStr;
    read._id = self.book_id;
    read.imageStr = self.imageStr;
    read.offset = 0;
    read.book_title = self.name;
    
    [self.navigationController pushViewController:read animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
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
