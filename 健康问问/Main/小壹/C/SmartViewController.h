//
//  SmartViewController.h
//  健康问问
//
//  Created by  枫自飘零 on 15/9/6.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmartViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property NSMutableArray *array;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property NSString *text;

@end
