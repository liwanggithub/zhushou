//
//  CollectionViewCell.m
//  91助手
//
//  Created by 李旺 on 2017/1/13.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(void)setModel:(YingYongModel *)model{
    if(_model==nil){
        _model=[[YingYongModel alloc]init];
    }
    _model=model;
    [_picview sd_setImageWithURL:[NSURL URLWithString:_model.icon]];
    NSArray*title=[_model.name componentsSeparatedByString:@"-"];
    _title.text=title[0];
    [_title sizeToFit];
    _title.lineBreakMode=NSLineBreakByWordWrapping;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
