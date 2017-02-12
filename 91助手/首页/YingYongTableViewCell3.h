//
//  YingYongTableViewCell3.h
//  91助手
//
//  Created by 李旺 on 2017/1/16.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelModel.h"

@interface YingYongTableViewCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jianrongxing;
@property (weak, nonatomic) IBOutlet UILabel *zuozhe;
@property (weak, nonatomic) IBOutlet UILabel *yuyan;
@property (weak, nonatomic) IBOutlet UILabel *shijian;
@property (weak, nonatomic) IBOutlet UILabel *fenlei;
@property (weak, nonatomic) IBOutlet UILabel *xiazai;
@property(nonatomic,strong)LabelModel*model;
@end
