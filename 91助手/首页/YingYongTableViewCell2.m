//
//  YingYongTableViewCell2.m
//  91助手
//
//  Created by 李旺 on 2017/1/15.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "YingYongTableViewCell2.h"

@implementation YingYongTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)button:(UIButton*)sender {
    sender.selected=!sender.selected;
    if(sender.selected){
       _textH = [_neirong.text boundingRectWithSize:CGSizeMake(ScreenWidth-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
        if(_textH<120){
            _textH=120;
        }
    }else{
        _textH =120;
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"cellheight" object:@(_textH)];
    
    }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
