//
//  FenlLeiViewController.m
//  91助手
//
//  Created by 李旺 on 2017/1/11.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "FenlLeiViewController.h"
#import "SuperTableViewController.h"

@interface FenlLeiViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segement;
@property (strong, nonatomic)  UIScrollView *scrollview;
@end

@implementation FenlLeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, ScreenHeight-105)];
    _scrollview.delegate=self;
    _scrollview.directionalLockEnabled=YES;
    _scrollview.bounces=NO;
    _scrollview.showsVerticalScrollIndicator=NO;
    _scrollview.showsHorizontalScrollIndicator=NO;
    _scrollview.pagingEnabled=YES;
    [self.view addSubview:_scrollview];
    [self addchildVC];
    [self scrollViewDidEndDecelerating:_scrollview];
    // Do any additional setup after loading the view.
}
- (IBAction)segment:(id)sender {
    _scrollview.contentOffset=CGPointMake(ScreenWidth*_segement.selectedSegmentIndex, 0);
    [self scrollViewDidEndScrollingAnimation:_scrollview];
}

-(void)addchildVC{
    SuperTableViewController*yingyong=[[SuperTableViewController alloc]init];
    yingyong.url=@"http://applebbx.sj.91.com/soft/phone/cat.aspx?act=213&cuid=c0b61e0665fecc566f773be70751bdfbbcdab926&pi=1&spid=2&imei=1DB79479-028B-4538-A915-9BA4B2ADD673&osv=10.1.1&dm=iPhone8,4&sv=3.1.3&nt=10&mt=1&pid=2";
    [self addChildViewController:yingyong];
    SuperTableViewController*youxi=[[SuperTableViewController alloc]init];
    youxi.url=@"http://applebbx.sj.91.com/soft/phone/cat.aspx?act=218&cuid=c0b61e0665fecc566f773be70751bdfbbcdab926&pi=1&spid=2&imei=1DB79479-028B-4538-A915-9BA4B2ADD673&osv=10.1.1&dm=iPhone8,4&sv=3.1.3&nt=10&mt=1&pid=2";
    [self addChildViewController:youxi];
    _scrollview.contentSize=CGSizeMake(self.childViewControllers.count*ScreenWidth, _scrollview.bounds.size.height);
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / ScreenWidth;
    SuperTableViewController *willShowChildVc = self.childViewControllers[index];
    if (willShowChildVc.isViewLoaded) return;
    willShowChildVc.view.frame = _scrollview.bounds;
    [scrollView addSubview:willShowChildVc.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:_scrollview];
    // segment scroll 互动
    int index = _scrollview.contentOffset.x / ScreenWidth;
    _segement.selectedSegmentIndex=index;
    
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
