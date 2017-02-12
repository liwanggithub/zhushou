//
//  TIeBaViewController.m
//  91助手
//
//  Created by 李旺 on 2017/1/11.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "TIeBaViewController.h"

@interface TIeBaViewController ()
@property(nonatomic,strong)UIWebView*web;
@end

@implementation TIeBaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bar_back_selected"]  style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.title=@"百度贴吧";
    
    
    //url编码
    NSString * str = [_name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://tieba.baidu.com/f?kw=%@&red_tag=0404197324",str]];
    _web=[[UIWebView alloc]initWithFrame:ScreenFrame];
    //自动对页面进行缩放以适应屏幕
    _web.scalesPageToFit = YES;
    NSURLRequest*request=[NSURLRequest requestWithURL:url];
    [_web loadRequest:request];
    [self.view addSubview:_web];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cancel{
    
    self.navigationController.navigationBarHidden=YES;
    [self setNeedsFocusUpdate];
    [self updateViewConstraints];
    [self.navigationController popViewControllerAnimated:YES];
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
