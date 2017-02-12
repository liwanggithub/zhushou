//
//  LiaoBaViewController.m
//  91助手
//
//  Created by 李旺 on 2017/1/11.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "LiaoBaViewController.h"
#import "LiaoBaTableViewCell.h"
#import "CiJiLiaoBaViewController.h"

@interface LiaoBaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation LiaoBaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _act=@"http://applebbx.sj.91.com/api/?act=702&cuid=c0b61e0665fecc566f773be70751bdfbbcdab926&spid=2&imei=1DB79479-028B-4538-A915-9BA4B2ADD673&osv=10.1.1&dm=iPhone8,4&sv=3.1.3&nt=10&mt=1&pid=2";
    _dataArray=[NSMutableArray array];
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
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"感兴趣的贴吧";
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CiJiLiaoBaViewController*ciji=[[CiJiLiaoBaViewController alloc]init];
    ciji.act=_dataArray[indexPath.row][@"act"];
    ciji.title=_dataArray[indexPath.row][@"name"];
    [self showViewController:ciji sender:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
//    if ([segue.identifier isEqualToString:@"ciji"]) {
//        CiJiLiaoBaViewController*ciji=[segue destinationViewController];
//        
//        
//        
//    }
//}
// In a storyboard-based application, you will often want to do a little preparation before navigation


@end
