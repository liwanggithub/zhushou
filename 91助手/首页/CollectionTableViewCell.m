//
//  CollectionTableViewCell.m
//  91助手
//
//  Created by 李旺 on 2017/1/12.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import "CollectionTableViewCell.h"
#import "CollectionViewCell.h"
#import "YingYongViewController.h"
#import "MoreViewController.h"

@implementation CollectionTableViewCell 
-(instancetype)init{
    if(self=[super init]){
        
    }
    return self;
}

-(void)setDataArray:(NSArray *)dataArray{
    if(_dataArray==nil){
        _dataArray=[NSArray array];
    }
    _dataArray=dataArray;
    _collect.delegate=self;
    _collect.dataSource=self;
    
    [_collect registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"item"];
    //NSLog(@"%lu",(unsigned long)_dataArray.count);
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collect reloadData];
    });
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    YingYongModel*model=[[YingYongModel alloc]init];
    [model setValuesForKeysWithDictionary:_dataArray[indexPath.item]];
    cell.model=model;
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    UIViewController *uc=(UIViewController*)object;
  uc.navigationItem.backBarButtonItem.title=@"";
    if(_type){
        MoreViewController*more=[[MoreViewController alloc]init];
        more.url=_dataArray[indexPath.row][@"url"];
        more.title=_dataArray[indexPath.row][@"name"];
        [uc showViewController:more sender:nil];
    }else{
        YingYongViewController*vc=[[YingYongViewController alloc]init];
        YingYongModel*model=[[YingYongModel alloc]init];
        [model setValuesForKeysWithDictionary:_dataArray[indexPath.item]];
        vc.model=model;
        vc.url=model.detailUrl;
        
        
        
        [uc showViewController:vc sender:nil];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
