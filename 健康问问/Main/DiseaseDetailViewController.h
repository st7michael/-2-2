//
//  DiseaseDetailViewController.h
//  健康问问
//
//  Created by  枫自飘零 on 15/9/11.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiseaseDetailViewController : UIViewController
@property NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *diseaseImageView;
@property (weak, nonatomic) IBOutlet UITextView *contextView;
@property NSDictionary *detailDict;

@end
