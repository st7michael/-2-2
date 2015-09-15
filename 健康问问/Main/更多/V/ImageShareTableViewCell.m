//
//  ImageShareTableViewCell.m
//  健康问问
//
//  Created by 冯颐平 on 15/9/10.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "ImageShareTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ImageShareTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    UIView *view = [[UIView alloc ]initWithFrame:CGRectMake(0, 420, 320, 30)];
//                    
//                    view.backgroundColor = [UIColor redColor];
//                    
//                    [self.contentView addSubview:view];
//                    
                   // [self release];
    self.backgroundColor = [UIColor clearColor];
    //必须的
    self.backgroundColor = [UIColor  colorWithWhite:0.3 alpha:0.1];
    [self becomeFirstResponder];

}
- (void)setModel:(ImageShareModel *)model
{
    _model = model;
    NSString *string = _model.ImagepicUrl;
    
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:string]];
    NSLog(@"%@",_model.Imagedescrib);
    [self setNeedsLayout];
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    self.titleLabel.text = _model.Imagetitle;
    NSString *urlstr = [NSString stringWithFormat:@"神秘地址:%@",self.model.Imageurl];
    self.urlLabel.text = urlstr;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
