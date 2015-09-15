//
//  SmartCell.h
//  健康问问
//
//  Created by  枫自飘零 on 15/9/6.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXLabel.h"
@interface SmartCell : UITableViewCell

@property(nonatomic) NSDictionary * dic;
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet WXLabel *textsLabel;

@end
