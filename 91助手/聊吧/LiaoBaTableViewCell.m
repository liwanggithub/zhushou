//
//  LiaoBaTableViewCell.m
//  91助手
//
//  Created by 李旺 on 2017/1/11.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "LiaoBaTableViewCell.h"

@implementation LiaoBaTableViewCell
-(void)setIcon:(NSString *)icon{
    _icon=icon;
    [_picView sd_setImageWithURL:[NSURL URLWithString:icon]];
    _picView.layer.cornerRadius=30;
    _picView.layer.masksToBounds=YES;
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
