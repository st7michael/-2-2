//
//  NewsViewController.h
//  健康问问
//
//  Created by 冯颐平 on 15/9/6.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , assign) NSInteger newsIndex;
@property (nonatomic , strong) NSMutableArray *newsMtArray;
@end
