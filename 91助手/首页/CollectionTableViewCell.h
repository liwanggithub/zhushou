//
//  CollectionTableViewCell.h
//  91助手
//
//  Created by 李旺 on 2017/1/12.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YingYongModel.h"

@interface CollectionTableViewCell :  UITableViewCell  <UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collect;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowlayout;
@property(nonatomic,strong)NSArray*dataArray;
@property(nonatomic,assign)NSInteger act;
@property(nonatomic,strong)YingYongModel*model;
@property(nonatomic,strong)NSArray*cellArray;
@property(nonatomic,assign)BOOL type;
@end
