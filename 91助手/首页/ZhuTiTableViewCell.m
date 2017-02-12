//
//  ZhuTiTableViewCell.m
//  91助手
//
//  Created by 李旺 on 2017/1/17.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "ZhuTiTableViewCell.h"

@implementation ZhuTiTableViewCell
-(void)setModel:(YingYongModel *)model{
    if(_model==nil){
        _model=[[YingYongModel alloc]init];
    }
    _model=model;
    [_icon sd_setImageWithURL:[NSURL URLWithString:_model.icon]];
    _title.text=_model.name;
    _content.text=_model.summary;
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
