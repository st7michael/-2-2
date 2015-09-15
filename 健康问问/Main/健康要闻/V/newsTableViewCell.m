//
//  newsTableViewCell.m
//  健康问问
//
//  Created by 冯颐平 on 15/9/7.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "newsTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation newsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(newsModel *)model
{
    _model = model;
    
    [self setNeedsLayout];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, 100, 80);
    if ([_model.imageName isEqualToString:@"img/news/default.jpg"]) {
        self.imageView.image=[UIImage imageNamed:@"newImage.jpg"];
    }
    else
    {
    NSString *urlstring = [NSString stringWithFormat:@"http://www.yi18.net/%@",_model.imageName];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlstring]];
    }
  //  _titleLabel.frame = CGRectMake(200,0, 350, 70);
    _model.newsTitle=[_model.newsTitle stringByReplacingOccurrencesOfString:@"</font>" withString:@""];
    _model.newsTitle=[_model.newsTitle stringByReplacingOccurrencesOfString:@"<font color=\"red\">" withString:@""];
    NSLog(@"%@",_model.newsTitle);

    
    
    
    _titleLabel.text =_model.newsTitle;
    UIFont *myFont = [UIFont fontWithName:@"Arial" size:14];
    _titleLabel.font = myFont;
    [_titleLabel setNumberOfLines:0];
    
    
    
    
    CGSize constraint = CGSizeMake(250, 50000.0f);
   // CGSize _size = [ _model.newsTitle sizeWithFont:myFont constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];
   // [_titleLabel setFrame:CGRectMake(100, 30, 0, 0)];
    CGSize _size2 = [_titleLabel sizeThatFits:constraint];
   // [_titleLabel sizeThatFits:_size2];
    
    [_titleLabel setFrame:CGRectMake(115, 30, _size2.width, _size2.height)];

    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
