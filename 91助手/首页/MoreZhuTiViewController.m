//
//  MoreZhuTiViewController.m
//  91助手
//
//  Created by 李旺 on 2017/1/17.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "MoreZhuTiViewController.h"
#import "YingYongModel.h"
#import "ZhuTiTableViewCell.h"
@interface MoreZhuTiViewController ()

@end

@implementation MoreZhuTiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZhuTiTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view.
}
-(void)GETDATA{
    WeakSelf;
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    [manager GET:weakSelf.url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.dataArray=[NSArray arrayWithArray:responseObject[@"Result"]];
        [self.tableView reloadData];
    } failure:nil];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   ZhuTiTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    YingYongModel*model=[[YingYongModel alloc]init];
    [model setValuesForKeysWithDictionary:self.dataArray[indexPath.row]];
    cell.model=model;
    return  cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreViewController*more=[[MoreViewController alloc]init];
    more.url=self.dataArray[indexPath.row][@"url"];
    more.title=self.dataArray[indexPath.row][@"name"];
    [self showViewController:more sender:nil];
    
    
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
