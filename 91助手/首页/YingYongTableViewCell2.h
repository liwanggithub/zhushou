//
//  YingYongTableViewCell2.h
//  91助手
//
//  Created by 李旺 on 2017/1/15.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YingYongTableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelheight;

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *neirong;
@property(nonatomic,assign)float textH ;

@end
