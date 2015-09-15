//
//  newsTableViewCell.h
//  健康问问
//
//  Created by 冯颐平 on 15/9/7.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newsModel.h"
@interface newsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic , strong)newsModel *model;
@end
