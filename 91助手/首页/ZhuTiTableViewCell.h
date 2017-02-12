//
//  ZhuTiTableViewCell.h
//  91助手
//
//  Created by 李旺 on 2017/1/17.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YingYongModel.h"

@interface ZhuTiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property(nonatomic,strong)YingYongModel*model;
@end
