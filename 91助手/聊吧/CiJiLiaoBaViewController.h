//
//  CiJiLiaoBaViewController.h
//  91助手
//
//  Created by 李旺 on 2017/1/11.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CiJiLiaoBaViewController : UIViewController
@property(nonatomic,strong)NSString*act;
@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*icon;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UITableView*tableView;
-(void)GETDATA:(NSString*)url;
@end
