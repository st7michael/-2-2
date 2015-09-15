//
//  moreInfoViewController.h
//  健康问问
//
//  Created by Yiqiao on 15/9/5.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface moreInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)NSString *searchId;
@end
