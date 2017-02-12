//
//  CiJiLiaoBaViewController.m
//  91助手
//
//  Created by 李旺 on 2017/1/11.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "CiJiLiaoBaViewController.h"
#import "LiaoBaTableViewCell.h"
#import "TIeBaViewController.h"

@interface CiJiLiaoBaViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CiJiLiaoBaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[NSMutableArray array];
    _tableView=[[UITableView alloc]initWithFrame:ScreenFrame];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self GETDATA:_act];
        [_tableView.mj_header endRefreshing];
    }];
    
    [_tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass( [LiaoBaTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"liaobacell"];
    LiaoBaTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"liaobacell"];
    cell.icon=_dataArray[indexPath.row][@"icon"];
    cell.name.text=_dataArray[indexPath.row][@"name"];
    
    return  cell;
}
-(void)GETDATA:(NSString*)url{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dataArray=responseObject[@"Result"];
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TIeBaViewController*vc=[[TIeBaViewController alloc]init];
    vc.name=_dataArray[indexPath.row][@"name"];
    [self showViewController:vc sender:nil];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


@end
