//
//  YingYongModel.h
//  91助手
//
//  Created by 李旺 on 2017/1/12.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YingYongModel : NSObject
//点进去的网址
@property(nonatomic,copy)NSString * detailUrl;
//星星的个数
@property(nonatomic,assign)NSInteger star;
//下载请求网址
@property(nonatomic,copy)NSString * downAct;
//图标
@property(nonatomic,copy)NSString * icon;
//名字
@property(nonatomic,copy)NSString * name;
//原价格
@property(nonatomic,copy)NSString * originalPrice;
//摘要
@property(nonatomic,copy)NSString * summary;
//现价格
@property(nonatomic,copy)NSString * price;
//下载量
@property(nonatomic,copy)NSString * downTimes;
//大小
@property(nonatomic,assign)NSUInteger size;
//作者
@property(nonatomic,copy)NSString *author;
//ID
@property(nonatomic,assign)NSInteger resId;
@property(nonatomic,copy)NSString *versionName;
@end
