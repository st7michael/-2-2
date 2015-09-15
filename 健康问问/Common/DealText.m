//
//  DealText.m
//  新浪微博
//
//  Created by  枫自飘零 on 15/8/21.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "DealText.h"

@implementation DealText


+(NSInteger)getTextHeightwihtFont14:(NSString* )text;
{
   
    if (text.length==0) {
        return 0;
    }
    NSDictionary *attrDic=@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                            };
    
    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:text attributes:attrDic];
    CGRect bound=[attrString boundingRectWithSize:CGSizeMake(260, 3000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    return bound.size.height;

}
+(NSInteger)getTextHeightwihtFont13:(NSString *)text
{
    if (text.length==0) {
        return 0;
    }
    NSDictionary *attrDic=@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],
    };
    
    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:text attributes:attrDic];
    CGRect bound=[attrString boundingRectWithSize:CGSizeMake(260, 3000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    return bound.size.height;
}
+(CGRect)getTextSizewihtFont13:(NSString *)text
{
    NSDictionary *attrDic=@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],
                            };
    
    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:text attributes:attrDic];
    CGRect bound=[attrString boundingRectWithSize:CGSizeMake(260, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    return bound;

}
+(CGRect)getTextSizewihtFont14:(NSString *)text
{
    NSDictionary *attrDic=@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                            };
    
    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:text attributes:attrDic];
    CGRect bound=[attrString boundingRectWithSize:CGSizeMake(260, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    return bound;
    
}
@end
