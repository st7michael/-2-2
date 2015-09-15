//
//  HospitalListCell.h
//  健康问问
//
//  Created by  枫自飘零 on 15/9/4.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hospitalModel.h"

@interface HospitalListCell : UITableViewCell
@property  hospitalModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end
