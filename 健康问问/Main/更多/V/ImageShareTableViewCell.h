//
//  ImageShareTableViewCell.h
//  健康问问
//
//  Created by 冯颐平 on 15/9/10.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageShareModel.h"

@interface ImageShareTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;


@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (nonatomic ,strong) ImageShareModel *model;
@end
