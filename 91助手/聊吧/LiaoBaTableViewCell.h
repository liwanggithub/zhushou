//
//  LiaoBaTableViewCell.h
//  91助手
//
//  Created by 李旺 on 2017/1/11.
//  Copyright © 2017年 我赢职场. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiaoBaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property(nonatomic,strong)NSString*icon;
@property(nonatomic,strong)NSString*act;
@end
