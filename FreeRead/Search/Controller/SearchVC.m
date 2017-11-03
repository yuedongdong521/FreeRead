//
//  SearchVC.m
//  FreeRead
//
//  Created by lanou3g on 15/4/18.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "SearchVC.h"
#import "Ranking_ListVC.h"


@interface SearchVC ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain)UISearchBar *search;

@property (nonatomic, retain)NSMutableArray *resuleArr;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)UITableView *resultTabelView;

@end

@implementation SearchVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

  
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"搜索";
    self.navigationItem.titleView = title;
    self.navigationController.navigationBar.translucent = NO;
    [self makeView];
    
}



//- (void)setTableView:(UITableView *)tableView Hidden:(BOOL)hidden
//{
////    NSInteger height = hidden ? 0 : HEIGHT;
////    tableView.frame = CGRectMake(0, 0, WIDTH, height);
//}

- (void)viewWillAppear:(BOOL)animated
{
    [self.search endEditing:YES];
     self.tabBarController.tabBar.hidden = NO;
    self.resuleArr = [NSMutableArray array];
    [self.tableView reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"111111111111");
    [self.search endEditing:YES];
}

- (void)makeView
{
    self.view.userInteractionEnabled = YES;
    
    self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(WIDTH / 10, HEIGHT / 10, WIDTH / 10 * 8, 50)];
    self.search.backgroundColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    self.search.delegate = self;
    self.search.layer.cornerRadius = 12;
    self.search.layer.masksToBounds = YES;
    self.search.showsCancelButton = YES;
    
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:[UIColor whiteColor]];

    self.search.barTintColor = [UIColor colorWithRed:169 / 255.0 green:51 / 255.0 blue:21 / 255.0 alpha:1];
    
    UITextField *searchTF = [[UITextField alloc] init];
    searchTF = [[[self.search.subviews firstObject] subviews] lastObject];
    searchTF.placeholder = @"请输入书名或作者";
   
    [self.view addSubview:self.search];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH / 10, self.search.H + self.search.Y, WIDTH / 10 * 8, self.view.H - self.search.H - self.search.Y - 49 - 64) style:UITableViewStylePlain];
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resuleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT / 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.imageView.frame = CGRectMake(10, 0, WIDTH / 5, HEIGHT / 12);
    cell.imageView.image = [UIImage imageNamed:@"sousuo.png"];
    
    cell.textLabel.frame = CGRectMake(HEIGHT / 5 + 20, 0, WIDTH / 5 * 4 - 30, HEIGHT / 12);
    cell.textLabel.text = [self.resuleArr objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.search endEditing:YES];
    self.resuleArr = [NSMutableArray array];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ranking_ListVC *ranking = [[Ranking_ListVC alloc] init];
    ranking.class_id = [self.resuleArr objectAtIndex:indexPath.row];
    ranking.flag = 2;
    [self.navigationController pushViewController:ranking animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    Ranking_ListVC *ranking = [[Ranking_ListVC alloc] init];
    ranking.class_id = searchBar.text;
    ranking.flag = 2;
    [self.search endEditing:YES];
    [self.navigationController pushViewController:ranking animated:YES];
}



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *str = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/book/auto-complete?query=%@", searchText];
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        if (data != nil) {
            NSError *error = nil;
            id resule = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            self.resuleArr = [NSMutableArray array];
            self.resuleArr = [resule objectForKey:@"keywords"];

            [self.tableView reloadData];
        }
    }];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.search endEditing:YES];
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
