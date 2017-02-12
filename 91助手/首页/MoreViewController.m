//
//  MoreViewController.m
//  91助手
//
//  Created by 李旺 on 2017/1/17.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "MoreViewController.h"
#import "xiangqingTableViewCell.h"
#import "YingYongViewController.h"

@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[NSMutableArray array];
    //全屏tableview
    _tableView=[[UITableView alloc]initWithFrame:ScreenFrame];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self GETDATA];
        [_tableView.mj_header endRefreshing];
    }];
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([xiangqingTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"xiangqingcell"];
    [_tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(void)GETDATA{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
        [manager GET:_url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            _dataArray=[NSArray arrayWithArray:responseObject[@"Result"][@"items"]];
            [_tableView reloadData];
         } failure:nil];
        
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    xiangqingTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"xiangqingcell"];
    YingYongModel*model=[[YingYongModel alloc]init];
    [model setValuesForKeysWithDictionary:_dataArray[indexPath.row]];
    cell.model=model;
    return  cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        YingYongViewController*vc=[[YingYongViewController alloc]init];
        YingYongModel*model=[[YingYongModel alloc]init];
        [model setValuesForKeysWithDictionary:_dataArray[indexPath.row]];
        vc.model=model;
        vc.url=model.detailUrl;
        [self showViewController:vc sender:nil];
        
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
