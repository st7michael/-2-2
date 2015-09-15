//
//  DealText.h
//  新浪微博
//
//  Created by  枫自飘零 on 15/8/21.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DealText : NSObject


+(NSInteger)getTextHeightwihtFont14:(NSString* )text;
+(NSInteger)getTextHeightwihtFont13:(NSString *)text;
+(CGRect)getTextSizewihtFont13:(NSString *)text;
+(CGRect)getTextSizewihtFont14:(NSString *)text;
@end
