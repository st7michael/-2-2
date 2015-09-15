//
//  HospitalListViewController.h
//  健康问问
//
//  Created by  枫自飘零 on 15/8/31.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalListViewController :
UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL _isSelect;
    NSInteger index;

    
}
@property BOOL isReshData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *selectImage;
@property NSInteger page;

@property NSMutableArray *hospitaclArray;
@property NSString *hospitalID;
@property NSMutableArray *provinceArray;
@property NSMutableArray *cityArray;
@property BOOL isFisrt;


@end
