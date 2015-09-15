//
//  ImageSharedViewController.h
//  健康问问
//
//  Created by 冯颐平 on 15/9/10.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageSharedViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong) NSMutableArray *ImageShareArray;
@end
