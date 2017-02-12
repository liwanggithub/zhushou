//
//  ShouYeViewController.m
//  91助手
//
//  Created by 李旺 on 2017/1/11.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "ShouYeViewController.h"
#import "xiangqingTableViewCell.h"
#import "YingYongModel.h"
#import "YingYongViewController.h"
#import "headerView.h"
#import "CollectionTableViewCell.h"
#import "MoreViewController.h"
#import "MoreZhuTiViewController.h"

@interface ShouYeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray * requestArray;
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*imagearray;
@property(nonatomic,strong)NSMutableArray*titlearray;
@property(nonatomic,strong)NSMutableArray*urlarray;
@property(nonatomic,strong)SDCycleScrollView*lunbo;
@property(nonatomic,strong)NSString*jumpurl;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation ShouYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[NSMutableArray array];
    _requestArray=@[@"http://applebbx.sj.91.com/api/?act=708&pi=1&cuid=1a820c0140c54e360821b62bfa489aced1443d5a&spid=2&imei=3B789F3A-937B-458E-947A-6C276B18A396&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&nt=10&mt=1&pid=2",@"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=1a820c0140c54e360821b62bfa489aced1443d5a&act=244&imei=3B789F3A-937B-458E-947A-6C276B18A396&spid=2&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&top=20&mt=1&nt=10&pid=2",@"http://applebbx.sj.91.com/api/?act=246&pi=1&cuid=1a820c0140c54e360821b62bfa489aced1443d5a&spid=2&imei=3B789F3A-937B-458E-947A-6C276B18A396&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&nt=10&mt=1&pid=2",@"http://applebbx.sj.91.com/api/?act=236&pi=1&cuid=1a820c0140c54e360821b62bfa489aced1443d5a&spid=2&imei=3B789F3A-937B-458E-947A-6C276B18A396&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&nt=10&mt=1&pid=2",@"http://applebbx.sj.91.com/soft/phone/tag.aspx?cuid=1a820c0140c54e360821b62bfa489aced1443d5a&act=212&imei=3B789F3A-937B-458E-947A-6C276B18A396&spid=2&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&nt=10&mt=1&pid=2",@"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=1a820c0140c54e360821b62bfa489aced1443d5a&act=245&pi=1&imei=3B789F3A-937B-458E-947A-6C276B18A396&spid=2&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&nt=10&mt=1&pid=2",@"http://applebbx.sj.91.com/soft/phone/list.aspx?skip=10&pi=1&osv=10.0.1&spid=2&cuid=1a820c0140c54e360821b62bfa489aced1443d5a&imei=3B789F3A-937B-458E-947A-6C276B18A396&dm=iPhone8,1&sv=3.1.3&act=244&nt=10&pid=2&mt=1"];
    //推荐 244 &top=10
    for (int a=0; a<7; a++) {
        NSMutableArray*Arr=[NSMutableArray array];
        [_dataArray addObject:Arr];
    }
    _imagearray=[NSMutableArray array];
    _urlarray=[NSMutableArray array];
    _titlearray=[NSMutableArray array];
    //轮播图
    _lunbo=[[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    _lunbo.delegate=self;
    
    [self GETlunbo];
    //全屏tableview
    _tableView=[[UITableView alloc]initWithFrame:ScreenFrame];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableHeaderView=_lunbo;
    [self.view addSubview:_tableView];
    
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self GETDATA];
        NSLog(@"刷新");
         [_tableView.mj_header endRefreshing];
    }];
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([xiangqingTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"xiangqingcell"];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"collectcell"];
    [_tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    MoreViewController*more=[[MoreViewController alloc]init];
    more.url=_urlarray[index];
    more.title=_titlearray[index];
    [self showViewController:more sender:nil];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0||indexPath.section==2||indexPath.section==3||indexPath.section==4){
        CollectionTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"collectcell"];
        cell.dataArray=_dataArray[indexPath.section];
        if(indexPath.section==4){
            cell.flowlayout.itemSize=CGSizeMake(200,200);
            cell.type=YES;
        }
        return cell;
    }else{
        xiangqingTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"xiangqingcell"];
        YingYongModel*model=[[YingYongModel alloc]init];
        [model setValuesForKeysWithDictionary:_dataArray[indexPath.section][indexPath.row]];
        cell.model=model;
        return  cell;
    }
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    headerView*header=[[headerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    [header.button addTarget:self action:@selector(jumpxiangqing:) forControlEvents:UIControlEventTouchUpInside];
    
    if (section==4) {
        [header.button removeTarget:self action:@selector(jumpxiangqing:) forControlEvents:UIControlEventTouchUpInside];
       [header.button addTarget:self action:@selector(jumpzhuti:) forControlEvents:UIControlEventTouchUpInside];
    }else{
         header.button.tag=100+section;
        [header.button removeTarget:self action:@selector(jumpzhuti:) forControlEvents:UIControlEventTouchUpInside];
        [header.button addTarget:self action:@selector(jumpxiangqing:) forControlEvents:UIControlEventTouchUpInside];
    }
    if(section==0){
        header.title=@"精品推荐";
        
    }else if (section==1){
        header.title=@"热门推荐";
    }
    else if (section==2){
        header.title=@"限时免费";
    }else if (section==3){
        header.title=@"装机必备";
    }else if (section==4){
        header.title=@"应用专题";
    }else if (section==5){
        header.title=@"黑马闯入";
    }else if (section==6){
        header.title=@"编辑推荐";
    }
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(void)jumpxiangqing:(UIButton*)sender{
    
    MoreViewController*more=
    [[MoreViewController alloc]init];
    more.url=_requestArray[sender.tag-100];
    if([sender.superview isKindOfClass:[headerView class]]){
    headerView*hear=(headerView*)sender.superview;
        more.title=hear.title;
    }
    
    [self showViewController:more sender:nil];
}
-(void)jumpzhuti:(UIButton*)sender{
    MoreZhuTiViewController*more=
    [[MoreZhuTiViewController alloc]init];
    more.url=_requestArray[4];
    more.title=@"应用主题";
    [self showViewController:more sender:nil];
}

-(void)GETDATA{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    for (int a=0;a<7;a++) {
        NSString*url=[NSString stringWithFormat:@"%@",_requestArray[a]];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(a==4){
               _dataArray[a]=[NSArray arrayWithArray:responseObject[@"Result"]];
            }else{
                _dataArray[a]=[NSArray arrayWithArray:responseObject[@"Result"][@"items"]];
            }
            [_tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"11111111111%@1111",error);
        }];

    }
}
-(void)GETlunbo{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:@"http://applebbx.sj.91.com/softs.ashx?adlt=1&spid=2&osv=9.3.4&places=1&imei=B28D2280-A1CF-4CC1-9D6E-46ED69D26E0E&dm=iPhone5,4&sv=3.1.3&act=222&pid=2&cuid=b922959a9c737e488a3ee95721bfaec501dea09c&nt=10&mt=1" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray*array=responseObject[@"Result"];
        for (NSDictionary*dic in [array firstObject][@"Value"]) {
            [_urlarray addObject:dic[@"TargetUrl"] ];
            [_imagearray addObject:dic[@"LogoUrl"]];
            [_titlearray addObject:dic[@"Desc"]];
        };
        _lunbo.imageURLStringsGroup=_imagearray;
        
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0||section==2||section==3||section==4){
        return 1;
    }else{
        NSArray*array=_dataArray[section];
    NSLog(@"%lu",(unsigned long)array.count);
        return  array.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==4){
        return 450;
    }else{
    return 100;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1||indexPath.section==5||indexPath.section==6) {
    YingYongViewController*vc=[[YingYongViewController alloc]init];
    YingYongModel*model=[[YingYongModel alloc]init];
    [model setValuesForKeysWithDictionary:_dataArray[indexPath.section][indexPath.row]];
    vc.model=model;
    vc.url=model.detailUrl;
    [self showViewController:vc sender:nil];
    
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


@end


