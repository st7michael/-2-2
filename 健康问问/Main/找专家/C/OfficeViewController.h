//
//  OfficeViewController.h
//  健康问问
//
//  Created by  枫自飘零 on 15/9/5.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfficeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSString * hospitalID;
@property NSMutableArray *officeArray;


@end
