//
//  CollectionViewCell.h
//  91助手
//
//  Created by 李旺 on 2017/1/13.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YingYongModel.h"

@interface CollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)YingYongModel*model;
@property (weak, nonatomic) IBOutlet UIImageView *picview;

@property (weak, nonatomic) IBOutlet UILabel *title;

@end
