//
//  headerView.m
//  91助手
//
//  Created by 李旺 on 2017/1/12.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "headerView.h"
@implementation headerView
-(instancetype)initWithFrame:(CGRect)frame {
    if(self=[super initWithFrame:frame]){
        _label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 30)];
        [self addSubview:_label];
        self.backgroundColor=[UIColor whiteColor];
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame=CGRectMake(350, 0, 60, 30);
        [_button setTitle:@"更多>" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:_button];
    }
    
    return self;
}
-(void)setTitle:(NSString *)title{
    _label.text=title;
    _title=title;
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
