//
//  SuperTableViewController.m
//  91助手
//
//  Created by 李旺 on 2017/1/12.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "SuperTableViewController.h"
#import "MyTableViewCell.h"
#import "SuperCijiViewController.h"

@interface SuperTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation SuperTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[NSMutableArray array];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-105)];
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    //_tableView.bounces=NO;
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self GETDATA:_url];
        [_tableView.mj_header endRefreshing];
    }];
    [_tableView.mj_header beginRefreshing];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier: @"cell"];
     cell.name=_dataArray[indexPath.row][@"name"];
    cell.summary=_dataArray[indexPath.row][@"summary"];
    cell.picurl=_dataArray[indexPath.row][@"icon"];
    return  cell;
}
-(void)GETDATA:(NSString*)url{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dataArray=responseObject[@"Result"];
        [_tableView reloadData];
        NSLog(@"%@",_dataArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SuperCijiViewController*cijivc=[[SuperCijiViewController alloc]init];
    cijivc.array=_dataArray[indexPath.row][@"listTags"];
    cijivc.title=_dataArray[indexPath.row][@"name"];
    //NSLog(@"%@11111111111111111",cijivc.array);
    [self showViewController:cijivc sender:nil];
    //listTags
}

    // Do any additional setup after loading the view.


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
