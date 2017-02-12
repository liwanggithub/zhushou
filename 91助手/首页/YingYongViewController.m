//
//  YingYongViewController.m
//  91助手
//
//  Created by 李旺 on 2017/1/15.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "YingYongViewController.h"
#import "YingYongTableViewCell.h"
#import "YingYongTableViewCell2.h"
#import "YingYongTableViewCell3.h"
#import "CollectionTableViewCell.h"


@interface YingYongViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray*dataArray;
@property(nonatomic,strong)SDCycleScrollView*lunbo;
@property(nonatomic,strong)NSMutableArray*imageArray;
@property(nonatomic,strong)NSDictionary*urldic;
@property(nonatomic,assign)float cellheight;
@end

@implementation YingYongViewController

-(void)setModel:(YingYongModel *)model{
    if (_model==nil) {
        _model=[[YingYongModel alloc]init];
    }
    _model=model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _cellheight=170;
    _imageArray=[NSMutableArray array];
    _dataArray=[NSMutableArray array];
    _urldic=[NSDictionary dictionary];
    
    self.view.backgroundColor=[UIColor whiteColor];
    _tableView=[[UITableView alloc]initWithFrame:ScreenFrame];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self GETDATA];
        [_tableView.mj_header endRefreshing];
    }];
    [_tableView.mj_header beginRefreshing];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YingYongTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell1"];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YingYongTableViewCell2 class]) bundle:nil] forCellReuseIdentifier:@"cell2"];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell3"];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YingYongTableViewCell3 class]) bundle:nil]
     forCellReuseIdentifier:@"cell4"];
    [self.view addSubview:_tableView];
    _lunbo=[[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3.0, 450)];
        _tableView.tableHeaderView=_lunbo;
    [_tableView sendSubviewToBack:_tableView.tableHeaderView];
    
    [self setbutton];
    [self GETDATA];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cellheight:) name:@"cellheight" object:nil];
    //NSLog(@"%@",_url);
    // Do any additional setup after loading the view.
}
-(void)cellheight:(NSNotification*)sender{
    _cellheight=[sender.object floatValue]+50;
    [_tableView reloadData];
}
- (void)setbutton{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(30, 90, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"detail_back_normal"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dian) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(ScreenWidth-60, 90, 30, 30);
    [button1 setBackgroundImage:[UIImage imageNamed:@"detail_share_normal"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(fenxiang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    UISwipeGestureRecognizer*fanhui = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dian)];
    fanhui.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:fanhui];
}
- (void)fenxiang{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"亲,内容已复制到粘贴板,你可以随意分享到QQ,微信,微博...(打开对应的App输入框长按即可粘贴)" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        //复制
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"我在91助手上发现了一款软件[%@],感觉很不错,快下载一个事实吧.%@",_model.name,self.url];
    }];
}
- (void)dian{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)GETDATA{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    [manager GET:_model.detailUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _urldic=responseObject[@"Result"];
    _lunbo.imageURLStringsGroup=_urldic[@"snapshots"];
        

//        NSLog(@"%@",responseObject);
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"11111111111%@1111",error);
    }];
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        YingYongTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        YingYongModel*model=[[YingYongModel alloc]init];
        [model setValuesForKeysWithDictionary:_urldic];
        cell.model=model;
        return cell;
    }else if(indexPath.section==1){
        YingYongTableViewCell2*cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell.neirong.text=_urldic[@"desc"];
        return cell;
    }else if(indexPath.section==2){
        CollectionTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell3"];
    cell.dataArray=_urldic[@"recommendSofts"];
        return cell;
    }else{
        YingYongTableViewCell3*cell=[tableView dequeueReusableCellWithIdentifier:@"cell4"];
        LabelModel*model=[[LabelModel alloc]init];
        [model setValuesForKeysWithDictionary:_urldic];
        cell.model=model;
        return cell;
    }
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==1){
        return @"应用简介";
    }else if(section==2){
        return @"下载此应用的人还下载了";
    }else if(section==0){
        return @"";
    }else {
        return @"信息";
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        return _cellheight;
    }
    return 150;
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
