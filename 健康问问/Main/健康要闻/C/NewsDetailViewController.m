
//
//  NewsDetailViewController.m
//  健康问问
//
//  Created by 冯颐平 on 15/9/9.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
@interface NewsDetailViewController ()
{
    CGFloat scolheight;
    UILabel *label2;
    CGSize scolsize;
    UILabel *label;
    UIImageView *imageView;
}

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_left@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAct)];
    self.navigationItem.leftBarButtonItem = backbtn;

    
    // Do any additional setup after loading the view.
}
- (void)backAct
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)creatDetailView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
    scrollView.contentSize = CGSizeMake(KWidth, KWidth/7+KHeight/3+scolheight);
    [self.view addSubview:scrollView];
    [scrollView addSubview:label];
    [scrollView addSubview:imageView];
//    label = [[UILabel alloc]initWithFrame:CGRectMake(KWidth/12, 0, KWidth*10/12, KHeight/10*2)];
//
//    //label.backgroundColor = [UIColor redColor];
//
//    label.text = _model.newsTitle;
//    UIFont *myFont = [UIFont fontWithName:@"Arial" size:17];
//    label.font = myFont;
//    [label setNumberOfLines:0];
//    CGSize constraint = CGSizeMake(KWidth*10/12, 20000.0f);
//    CGSize _size = [ _model.newsTitle sizeWithFont:myFont constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];
//    [label setFrame:CGRectMake(KWidth/12, 10, _size.width, _size.height)];
//    [scrollView addSubview:label];
//    
//    
//    
//    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KWidth/25, KWidth/7, KWidth*23/25, KHeight/3)];
//    //imageView.backgroundColor = [UIColor redColor];
//    NSString *urlstring = [NSString stringWithFormat:@"http://www.yi18.net/%@",_model.imageName];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:urlstring]];
//    [scrollView addSubview:imageView];
    
//    label2 = [[UILabel alloc]initWithFrame:CGRectMake(KWidth/12, 0, KWidth*10/12, KHeight/10*2)];
//    
//    //label.backgroundColor = [UIColor redColor];
//    
//    label2.text = _model.newsContent;
//    UIFont *myFont2 = [UIFont fontWithName:@"Arial" size:20];
//    label2.font = myFont2;
//    [label2 setNumberOfLines:0];
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label2.text];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    [paragraphStyle setLineSpacing:10];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label2.text.length)];
//    
//    label2.attributedText = attributedString;
//    CGSize constraint2 = CGSizeMake(KWidth*23/25, 20000.0f);
//    CGSize _size2 = [label2 sizeThatFits:constraint2];
//    scolsize = _size2;
//    scolheight = scolsize.height+2000;
//    //[label2 sizeToFit];
//    //CGSize _size2 = [ _model.newsContent sizeWithFont:myFont2 constrainedToSize:constraint2 lineBreakMode:UILineBreakModeCharacterWrap];
//    [label2 setFrame:CGRectMake(KWidth/25, imageView.frame.origin.y+imageView.frame.size.height, _size2.width, _size2.height+50)];
    [scrollView addSubview:label2];
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setModel:(newsModel *)model
{
    _model = model;
    _model.newsTitle=[_model.newsTitle stringByReplacingOccurrencesOfString:@"</font>" withString:@""];
    _model.newsTitle=[_model.newsTitle stringByReplacingOccurrencesOfString:@"<font color=\"red\">" withString:@""];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(KWidth/12, 0, KWidth*10/12, KHeight/10*2)];
    
    //label.backgroundColor = [UIColor redColor];
    
    label.text = _model.newsTitle;
    UIFont *myFont = [UIFont fontWithName:@"Arial" size:17];
    label.font = myFont;
    [label setNumberOfLines:0];
    CGSize constraint = CGSizeMake(KWidth*10/12, 20000.0f);
    CGSize _size = [label sizeThatFits:constraint];
    //CGSize _size = [ _model.newsTitle sizeWithFont:myFont constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];
    [label setFrame:CGRectMake(KWidth/12, 10, _size.width, _size.height)];
    
    
    
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KWidth/25, KWidth/7, KWidth*23/25, KHeight/3)];
    //imageView.backgroundColor = [UIColor redColor];
    NSString *urlstring = [NSString stringWithFormat:@"http://www.yi18.net/%@",_model.imageName];
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlstring]];
    
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(KWidth/12, 0, KWidth*10/12, KHeight/10*2)];
    
    //label.backgroundColor = [UIColor redColor];
    
    label2.text = _model.newsContent;
    UIFont *myFont2 = [UIFont fontWithName:@"Arial" size:20];
    label2.font = myFont2;
    [label2 setNumberOfLines:0];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label2.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label2.text.length)];
    
    label2.attributedText = attributedString;
    CGSize constraint2 = CGSizeMake(KWidth*23/25, 20000.0f);
    CGSize _size2 = [label2 sizeThatFits:constraint2];
    scolsize = _size2;
    scolheight = scolsize.height+100;
    //[label2 sizeToFit];
    //CGSize _size2 = [ _model.newsContent sizeWithFont:myFont2 constrainedToSize:constraint2 lineBreakMode:UILineBreakModeCharacterWrap];
    [label2 setFrame:CGRectMake(KWidth/25, imageView.frame.origin.y+imageView.frame.size.height, _size2.width, _size2.height+50)];
    NSLog(@"%f",scolsize.height);
   // scolheight = scolsize.height+2000;
    NSLog(@"%@",_model.newsContent);
    [self creatDetailView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
