//
//  SmartCell.m
//  健康问问
//
//  Created by  枫自飘零 on 15/9/6.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "SmartCell.h"
#import "DealText.h"
#import "UIViewExt.h"
#import "Common.h"
@implementation SmartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    // Initialization code
}

-(void)setDic:(NSDictionary *)dic
{
    if (dic!=nil) {
        _dic=dic;
        
        
        self.textsLabel.text=[_dic objectForKey:@"text"];
        
         [self setNeedsLayout];
    }
   

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect=[DealText getTextSizewihtFont14:[_dic objectForKey:@"text"]];


    if ([[_dic objectForKey:@"isUser"]isEqualToString:@"0"]) {
               [_iconView setImage:[UIImage imageNamed:@"center_1.png"]];
        [_iconView setFrame:CGRectMake(8, 19, 55, 54)];
        [_bgView setImage:[UIImage imageNamed:@"chatfrom_bg_normal.png"]];
        [self.bgView setFrame:CGRectMake(70, 26, rect.size.width+30, rect.size.height+20)];
        [_textsLabel setFrame:CGRectMake(88, 34, rect.size.width, rect.size.height)];
    }
    else
    {

        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"iconImage"]!=nil) {
            NSData *data=[defaults objectForKey:@"iconImage"];
            UIImage *iconImage=[UIImage imageWithData:data];
            [_iconView setImage:iconImage];
        }else
        {
        
            [_iconView setImage:[UIImage imageNamed:@"add_user"]];
        
        }
        _iconView.left=KWidth-63;
        [_bgView setImage:[UIImage imageNamed:@"chatto_bg_normal.png"]];
        [_bgView setFrame:CGRectMake(KWidth-70-(rect.size.width+30), 26, rect.size.width+30, rect.size.height+20)];
        [_textsLabel setFrame:CGRectMake(KWidth-70-rect.size.width-20, 34, rect.size.width, rect.size.height)];
        
        _textsLabel.left=KWidth-70-rect.size.width-20;
        

    }
    


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
