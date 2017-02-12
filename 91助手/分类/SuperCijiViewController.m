//
//  SuperCijiViewController.m
//  91助手
//
//  Created by 李旺 on 2017/1/12.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "SuperCijiViewController.h"
#import "BiaoDanViewController.h"

@interface SuperCijiViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView*titleScroll;
@property(nonatomic,strong)UISegmentedControl*titleSegment;
@property(nonatomic,strong)UIView*redview;
@property(nonatomic,strong)UIScrollView*scroll;
//@property(nonatomic,strong)NSString*url;
@end

@implementation SuperCijiViewController

-(void)setArray:(NSArray *)array{
    if(_array==nil){
        _array=[NSArray array];
    }
    _array=array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"22222222222");
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _titleScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,60, ScreenWidth, 30)];
    _titleScroll.contentSize=CGSizeMake(ScreenWidth*_titleSegment.numberOfSegments, 30);
    _titleScroll.backgroundColor=[UIColor whiteColor];
    _titleScroll.bounces=NO;
    _titleScroll.showsVerticalScrollIndicator=NO;
    _titleScroll.showsHorizontalScrollIndicator=NO;
    _titleScroll.directionalLockEnabled=YES;
    NSMutableArray*tagname=[NSMutableArray array];
    for (NSDictionary*dic in _array) {
        [tagname addObject:dic[@"tagName"]];
    }
    NSLog(@"%@",tagname);
    _titleSegment=[[UISegmentedControl alloc]initWithItems:tagname];
    _titleSegment.frame=CGRectMake(0, 0, ScreenWidth, 28);
    _titleSegment.backgroundColor=[UIColor whiteColor];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName: [UIColor redColor]};
    [_titleSegment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName: [UIColor grayColor]};
    _titleSegment.tintColor=[UIColor clearColor];
    [_titleSegment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    [_titleSegment addTarget:self action:@selector(segmentmath) forControlEvents:UIControlEventValueChanged];
    [_titleScroll addSubview:_titleSegment];
    [self.view addSubview:_titleScroll];
    //小条
    //uiview 动画
    _redview=[[UIView alloc]initWithFrame:CGRectMake(0, 28, ScreenWidth/_titleSegment.numberOfSegments, 2)];
    _redview.backgroundColor=[UIColor redColor];
    [_titleScroll addSubview:_redview];
    //_scroll
    
    _scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 90, ScreenWidth,ScreenHeight-90)];
    // 不要自动调整scrollView的contentInset
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [self addchildVC];
    
    _scroll.contentSize=CGSizeMake(self.childViewControllers.count * ScreenWidth,ScreenHeight-90);
    _scroll.pagingEnabled=YES;
    _scroll.bounces=NO;
    _scroll.showsVerticalScrollIndicator=NO;
    _scroll.showsHorizontalScrollIndicator=NO;
    
    // Do any additional setup after loading the view.
    
    //tableViews
    _scroll.delegate=self;
    [self.view addSubview:_scroll];
    [self scrollViewDidEndDecelerating:_scroll];
    
}

//Titlesegment调用方法
-(void)segmentmath{
    [self animotion];
        _scroll.contentOffset=CGPointMake(ScreenWidth*_titleSegment.selectedSegmentIndex, 0);
    [self scrollViewDidEndScrollingAnimation:_scroll];
    
}
-(void)addchildVC{
    for (NSDictionary*dic in _array) {
        BiaoDanViewController*a=[[BiaoDanViewController alloc]init];
        a.title=dic[@"tagName"];
        a.url=dic[@"url"];
        NSLog(@"%@",a.url);
        [self addChildViewController:a];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 取出对应的子控制器
    int index = scrollView.contentOffset.x / scrollView.sd_width;
    UIViewController *willShowChildVc = self. childViewControllers[index];
    
    // 如果控制器的view已经被创建过，就直接返回
    if (willShowChildVc.isViewLoaded) return;
    // 添加子控制器的view到scrollView身上
    willShowChildVc.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowChildVc.view];
}

/**
 * 当减速完毕的时候调用（人为拖拽scrollView，手松开后scrollView慢慢减速完毕到静止）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    // 点击按钮
    int index = _scroll.contentOffset.x / _scroll.sd_width;
    _titleSegment.selectedSegmentIndex=index;
    [self segmentmath];
}

//uiview动画
-(void)animotion{
    [UIView beginAnimations:@"1" context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:0.5];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置动画执行完毕调用的事件
    [UIView setAnimationRepeatAutoreverses:NO];
    _redview.center=CGPointMake(ScreenWidth/_titleSegment.numberOfSegments*_titleSegment.selectedSegmentIndex+ScreenWidth/(_titleSegment.numberOfSegments*2), _redview.center.y) ;
    [UIView commitAnimations];
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
