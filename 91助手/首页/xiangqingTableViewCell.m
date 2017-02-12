//
//  xiangqingTableViewCell.m
//  91助手
//
//  Created by 李旺 on 2017/1/12.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "xiangqingTableViewCell.h"

@implementation xiangqingTableViewCell

-(void)setModel:(YingYongModel *)model{
    _model=model;
    [_tubiao sd_setImageWithURL:[NSURL URLWithString:_model.icon]];
    _biaoti.text=_model.name;
    _xiazailiang.text = [NSString stringWithFormat:@"%@次下载",_model.downTimes];
    _size.text = [NSString stringWithFormat:@"%0.2fMB",model.size/1024/1024.0];
    if (_model.star==0) {
        _xing.hidden=YES;
    }
    for (int a=0;a<=_model.star-1;a++){
        UIButton*button=_xing.subviews[a];
        button.selected=YES;
    }
    if ([_model.price isEqualToString:@"0.00"]||_model.price==nil) {
        _xianjia.hidden = YES;
    }else{
        [_button setTitle:model.price forState:UIControlStateNormal];
    }
    if ([_model.originalPrice isEqualToString:@"0.00"]||_model.originalPrice==nil) {
        _yuanjia.hidden=YES;
    }else{
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:_model.originalPrice attributes:attribtDic];
        _yuanjia.attributedText=attribtStr;
    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)button:(id)sender {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:_model.downAct parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = responseObject[@"Result"];
        _url = dic[@"appleDetailUrl"];
    }
         failure:nil];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.url]options:@{UIApplicationOpenURLOptionsSourceApplicationKey:@YES} completionHandler:nil];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
