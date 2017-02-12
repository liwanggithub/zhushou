//
//  YingYongTableViewCell3.m
//  91助手
//
//  Created by 李旺 on 2017/1/16.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "YingYongTableViewCell3.h"

@implementation YingYongTableViewCell3
-(void)setModel:(LabelModel *)model{
    if(_model==nil){
        _model=[[LabelModel alloc]init];
    }
    _model=model;
    _xiazai.text=[NSString stringWithFormat:@"下载量:%@次下载",_model.downTimes];
    _fenlei.text=[NSString stringWithFormat:@"分类:%@",_model.cateName];
    _shijian.text=[NSString stringWithFormat:@"时间:%@",_model.updateTime];
    _yuyan.text=[NSString stringWithFormat:@"语言:%@",_model.updateTime];
    _zuozhe.text=[NSString stringWithFormat:@"作者:%@",_model.author];
    _jianrongxing.text=[NSString stringWithFormat:@"兼容性:%@",_model.requirement];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
