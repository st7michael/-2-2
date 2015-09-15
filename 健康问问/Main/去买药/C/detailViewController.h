//
//  detailViewController.h
//  健康问问
//
//  Created by Yiqiao on 15/9/4.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "buyTabletViewController.h"
@interface detailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSString *searchTitle;

@end
