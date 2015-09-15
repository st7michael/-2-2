//
//  DiseaseViewController.h
//  健康问问
//
//  Created by  枫自飘零 on 15/9/11.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiseaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property NSString* diseaseName;
@property NSMutableArray *array;
@property UITableView *tableView;
@end
