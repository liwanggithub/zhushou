//
//  xiangqingTableViewCell.h
//  91助手
//
//  Created by 李旺 on 2017/1/12.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YingYongModel.h"

@interface xiangqingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *button;
@property(nonatomic,strong)YingYongModel*model;
@property (weak, nonatomic) IBOutlet UIImageView *tubiao;
@property (weak, nonatomic) IBOutlet UIStackView *xing;
@property (weak, nonatomic) IBOutlet UILabel *biaoti;
@property (weak, nonatomic) IBOutlet UILabel *xiazailiang;
@property (weak, nonatomic) IBOutlet UILabel *size;
@property (weak, nonatomic) IBOutlet UILabel *yuanjia;
@property (weak, nonatomic) IBOutlet UILabel *xianjia;
@property(nonatomic,strong)NSString*url;
@end
