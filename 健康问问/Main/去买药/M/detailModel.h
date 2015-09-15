//
//  detailModel.h
//  健康问问
//
//  Created by Yiqiao on 15/9/5.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface detailModel : NSObject

//药品图片
@property (nonatomic,copy)NSString *image;
//药品名字
@property (nonatomic,copy)NSString *title;
//药品序列号
@property (nonatomic,copy)NSString *idNumber;
//药品信息正文
@property (nonatomic,copy)NSString *message;
//药品公司
@property (nonatomic,copy)NSString *factory;
//建议
@property (nonatomic,copy)NSString *tipsTAG;
//国药准字
@property (nonatomic,copy)NSString *chinaId;
//药品类别
@property (nonatomic,copy)NSString *categoryName;


@end
