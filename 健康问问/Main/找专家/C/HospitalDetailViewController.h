//
//  HospitalDetailViewController.h
//  健康问问
//
//  Created by  枫自飘零 on 15/9/5.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *mtypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property NSString *hospitalID;
@property NSMutableDictionary *hospitalDict;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end
