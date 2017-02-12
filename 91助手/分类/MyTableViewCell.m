//
//  MyTableViewCell.m
//  91助手
//
//  Created by 李旺 on 2017/1/12.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "MyTableViewCell.h"


@implementation MyTableViewCell
-(void)setName:(NSString *)name{
    _name=name;
    _title.text=name;
}
-(void)setPicurl:(NSString *)picurl{
    _picurl=picurl;
    [_picview sd_setImageWithURL:[NSURL URLWithString:picurl]];
}
-(void)setSummary:(NSString *)summary{
    _summary=summary;
    _subtitle.text=summary;
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
