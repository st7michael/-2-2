//
//  MainViewController.h
//  健康问问
//
//  Created by  枫自飘零 on 15/8/27.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *rb1;
@property (weak, nonatomic) IBOutlet UIButton *lb3;
@property (weak, nonatomic) IBOutlet UIButton *rb2;
@property (weak, nonatomic) IBOutlet UIButton *rb3;

@property (weak, nonatomic) IBOutlet UIButton *lb1;
@property (weak, nonatomic) IBOutlet UIButton *lb2;
@property (weak, nonatomic) IBOutlet UISearchBar *searchView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property  UIPageControl *pc;
@property NSInteger page;
@property UITableView *tableView;
@property BOOL isHidden;

@end
