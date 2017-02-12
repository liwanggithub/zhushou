//
//  BiaoDanViewController.m
//  91助手
//
//  Created by 李旺 on 2017/1/13.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "BiaoDanViewController.h"
#import "xiangqingTableViewCell.h"
#import "YingYongViewController.h"

@interface BiaoDanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableArray*cellArray;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSString*urlstr;
@end

@implementation BiaoDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _urlstr=[NSString stringWithString:_url];
    
    _page=1;
    _dataArray=[NSMutableArray array];
    _cellArray=[NSMutableArray array];
    _tableView=[[UITableView alloc]initWithFrame:ScreenFrame];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    WeakSelf;
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page=1;
        NSLog(@"%@",weakSelf.urlstr);
        [_cellArray removeAllObjects];
        [_tableView reloadData];
        [weakSelf GETdata:weakSelf.tableView];
        NSLog(@"|||||||||||||");
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.url=[NSString stringWithFormat:@"%@&pi=%d",weakSelf.urlstr,++weakSelf.page];
        [weakSelf GETdata:weakSelf.tableView];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    [self.view addSubview:_tableView];
    [_tableView.mj_header beginRefreshing];
    
    
    //
    
    // Do any additional setup after loading the view.
}
-(void)GETdata:(UITableView*)sender{
    WeakSelf;
    AFHTTPSessionManager*managerb=[AFHTTPSessionManager manager];
    [managerb GET:_url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求数据成功11111111111111111111");
              NSLog(@"%@",task.currentRequest.URL);
        [weakSelf.cellArray addObjectsFromArray:responseObject[@"Result"][@"items"]];
        [sender reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([xiangqingTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    xiangqingTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    YingYongModel*model=[[YingYongModel alloc]init];
    [model setValuesForKeysWithDictionary:_cellArray[indexPath.row]];
    cell.model=model;
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YingYongViewController*vc=[[YingYongViewController alloc]init];
    YingYongModel*model=[[YingYongModel alloc]init];
    [model setValuesForKeysWithDictionary:_cellArray[indexPath.row]];
    vc.model=model;
    vc.url=model.detailUrl;
    [self showViewController:vc sender:nil];
    

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
