//
//  SouSuoViewController.m
//  91助手
//
//  Created by 李旺 on 2017/1/11.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "SouSuoViewController.h"
#import "LiaoBaTableViewCell.h"
#import "YingYongModel.h"
#import "MoreViewController.h"
#import "SLiaobaViewController.h"

@interface SouSuoViewController ()<UISearchBarDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic,strong)NSMutableArray * buttonArray;
@property(nonatomic,strong)NSMutableArray * cellArray;
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSMutableArray*lishi;
@property(nonatomic,strong)UIScrollView * scrollview;

@property(nonatomic,strong)NSString*keyword;
@property(nonatomic,strong)NSString*urlstr;
@property(nonatomic,strong)MoreViewController * xiangqing;
@property(nonatomic,strong)SLiaobaViewController * liaoba;
@end

@implementation SouSuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lishi=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]valueForKey:@"lishi"]];
    _buttonArray=[NSMutableArray array];
    _cellArray=[NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _scrollview=[[UIScrollView alloc]init];
    UILabel*title=[[UILabel alloc]initWithFrame:CGRectMake(30, 65,300, 45)];
    title.text=@"热门搜索";
    [self.view insertSubview:title atIndex:0];
    [self.view addSubview:_scrollview];
    
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchBar.mas_bottom);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    _scrollview.delegate=self;
    _scrollview.directionalLockEnabled=YES;
    _scrollview.bounces=NO;
    _scrollview.showsVerticalScrollIndicator=NO;
    _scrollview.showsHorizontalScrollIndicator=NO;
    _scrollview.backgroundColor=[UIColor whiteColor];
    _scrollview.pagingEnabled=YES;
    _scrollview.hidden=YES;
    
    
    [self SetButton];
    [self addchildVC];
    //历史视图
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 65, ScreenWidth, 340) style:UITableViewStylePlain];
    _tableview.bounces=NO;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.directionalLockEnabled=YES;
    _tableview.backgroundColor=[UIColor blackColor];
    _tableview.hidden=YES;
    
    [self.view addSubview:_tableview];
}


-(void)addchildVC{
    for (UIViewController*vc in self.childViewControllers) {
        [vc removeFromParentViewController];
    }
    SLiaobaViewController*liaoba=[[SLiaobaViewController alloc]init];
    liaoba.act=[NSString stringWithFormat:@"http://applebbx.sj.91.com/api/?spid=2&pi=1&osv=9.3.4&keyword=%@&dm=iPhone5,4&sv=3.1.3&act=203&pid=2&cuid=b922959a9c737e488a3ee95721bfaec501dea09c&nt=10&mt=1",_keyword];
    [self addChildViewController:liaoba];
    MoreViewController*yingyong=[[MoreViewController alloc]init];
    yingyong.url=[NSString stringWithFormat:@"http://applebbx.sj.91.com/api/?spid=2&pi=1&osv=9.3.4&keyword=%@&dm=iPhone5,4&sv=3.1.3&act=203&pid=2&cuid=b922959a9c737e488a3ee95721bfaec501dea09c&nt=10&mt=1",_keyword];
    [self addChildViewController:yingyong];
    _scrollview.contentSize=CGSizeMake(self.childViewControllers.count*ScreenWidth, _scrollview.bounds.size.height);
    [self scrollViewDidEndDecelerating:_scrollview];
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    _searchBar.showsCancelButton = YES;
    //改变showsCancelButton的字体
    for(UIView *view in  [[[_searchBar subviews] objectAtIndex:0] subviews]){
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]){
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel  setTintColor:[UIColor blueColor]];
            [cancel.titleLabel setTextColor:[UIColor blueColor]];
        }
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / ScreenWidth;
    UIViewController *willShowChildVc = self.childViewControllers[index];
    if (willShowChildVc.isViewLoaded)
    {
        return ;
    }
    willShowChildVc.view.frame = _scrollview.bounds;
    [scrollView addSubview:willShowChildVc.view];
}
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    _scrollview.contentOffset=CGPointMake(ScreenWidth*selectedScope, 0);
    [self scrollViewDidEndScrollingAnimation:_scrollview];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    _keyword=[_searchBar.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    [self addchildVC];
    //添加历史记录
    BOOL add=YES;
    for (NSString*str in _lishi) {
        if ([_searchBar.text isEqualToString:str]) {
            add=NO;
        }
    }
    if(add){
    [_lishi insertObject:_searchBar.text atIndex:0];
    [[NSUserDefaults standardUserDefaults]setObject:_lishi forKey:@"lishi"];
    }
    _tableview.hidden=YES;
    _searchBar.showsScopeBar=YES;
    [_scrollview updateConstraints];
    _scrollview.hidden=NO;
    [_searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    _searchBar.text=nil;
    [_searchBar resignFirstResponder];
    _searchBar.showsScopeBar=NO;
    _scrollview.hidden=YES;
    _searchBar.showsCancelButton=NO;
    _tableview.hidden=YES;
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [_searchBar showsCancelButton];
    //显示历史记录
    _lishi=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]valueForKey:@"lishi"]];
    [_tableview reloadData];
    _tableview.hidden=NO;
    
    return YES;
}
-(void)SetButton{
    
    AFHTTPSessionManager*manger=[AFHTTPSessionManager manager];
    [manger GET:@"http://applebbx.sj.91.com/softs.ashx?cuid=1a820c0140c54e360821b62bfa489aced1443d5a&act=104&imei=3B789F3A-937B-458E-947A-6C276B18A396&spid=2&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&nt=10&mt=1&pid=2" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray*array=responseObject[@"Result"];
        for(int a=0;a<array.count;a++){
            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((a%4 * 80) + 30, 35 * ((a/4)+1)+90, 70, 25);
            [button setTitle:array[a] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            if (a%2 == 0) {
                button.backgroundColor = [UIColor redColor];
            }else{
                button.backgroundColor = [UIColor colorWithRed:201/255.0 green:251/255.0 blue:4/255.0 alpha:1];
            }
            [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
            if(_scrollview.hidden){
                [self.view insertSubview:button atIndex:0];
            }
            [_buttonArray addObject:button];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
-(void)button:(UIButton*)sender{
    [_cellArray removeAllObjects];
    _searchBar.text=sender.titleLabel.text;
    [self searchBarSearchButtonClicked:_searchBar];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:_scrollview];
    // segment scroll 互动
    int index = _scrollview.contentOffset.x / ScreenWidth;
    _searchBar.selectedScopeButtonIndex=index;
    
}
//历史tableview方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text=_lishi[indexPath.row];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(_lishi.count==0){
        _tableview.hidden=YES;
        return nil;
    }else{
    UIButton*qingchu=[UIButton buttonWithType:UIButtonTypeCustom];
    qingchu.frame=CGRectMake(0, 0, ScreenWidth, 40);
    [qingchu setTitle:@"清除" forState:UIControlStateNormal];
    [qingchu addTarget:self action:@selector(qingchu) forControlEvents:UIControlEventTouchUpInside];
    
    return qingchu;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
-(void)qingchu{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"lishi"];
    _tableview.hidden=YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_lishi.count<5){
        _tableview.sd_height=40*(_lishi.count+1);
    }else{
        _tableview.sd_height=240;
    }
    return _lishi.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
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
