//
//  MainViewController.m
//  健康问问
//
//  Created by  枫自飘零 on 15/8/27.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "MainViewController.h"

//买药主页面
#import "buyTabletViewController.h"
//个人中心页面
#import "selfViewController.h"
#import "SmartViewController.h"
#import "HospitalListViewController.h"
#import "Common.h"
#import "UIViewExt.h"
#import "DiseaseViewController.h"
#import "NewsViewController.h"
#import "MoreViewController.h"

#import <Masonry.h>

@interface MainViewController ()

@end



@implementation MainViewController


- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self _setTopView];
}

- (void)setButton{
    _rb1.backgroundColor = [UIColor redColor];
    [_rb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.3333);

    }];
    
    _lb1.backgroundColor = [UIColor blackColor];
    [_lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.3333);

    }];
    
}

- (void)_setTopView
{
    _scrollView.contentSize=CGSizeMake(KWidth*4, 128);
    for (int i=1; i<=4; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((i-1)*KWidth, 0, KWidth, 159)];
        NSString *str=[NSString stringWithFormat:@"%d.jpg",i];
        [imageView setImage:[UIImage imageNamed:str]];
        [_scrollView addSubview:imageView];
    }
    _scrollView.pagingEnabled=YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;

    _pc=[[UIPageControl alloc]initWithFrame:CGRectMake(80, 120,200,60)];
    //_pc = [[UIPageControl alloc]init];
    
    _pc.numberOfPages=4;
    //[_pc addTarget:self action:@selector(pageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pc];
    _scrollView.delegate=self;
    //[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];

}


//- (IBAction)btAction1:(id)sender {
//    SmartViewController *vc=[[SmartViewController alloc]initWithNibName:@"SmartViewController" bundle:[NSBundle mainBundle]];
//    self.navigationController.navigationBar.hidden=NO;
//    [self.navigationController pushViewController:vc animated:YES];
//    
//   // NSLog(@"1");
//}
//- (IBAction)btAction2:(id)sender {
//    HospitalListViewController *vc=[[HospitalListViewController alloc]initWithNibName:@"HospitalListViewController" bundle:[NSBundle mainBundle]];
//    self.navigationController.navigationBar.hidden=NO;
//    
//    [self.navigationController pushViewController:vc animated:YES];
//}
////买药按钮
//- (IBAction)btAction3:(id)sender {
//    
//    buyTabletViewController *buyViewC = [[buyTabletViewController alloc]init];
//    [self.navigationController pushViewController:buyViewC animated:NO];
//    
//}
//- (IBAction)btAction4:(id)sender {
//    NewsViewController *vc = [[NewsViewController alloc]init];
//    vc.navigationItem.title =@"健康要闻";
//    self.navigationController.navigationBarHidden=NO;
//    [self.navigationController pushViewController:vc animated:YES];
//}
//- (IBAction)btAction5:(id)sender {
//    selfViewController *selfVC =[[selfViewController alloc]init];
//    [self.navigationController pushViewController:selfVC animated:NO];
//}
//- (IBAction)btAction6:(id)sender {
//    MoreViewController *vc = [[MoreViewController alloc]init];
//    vc.navigationItem.title = @"更多";
//     self.navigationController.navigationBarHidden=NO;
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btAction1:)];
//    [_imageView1 addGestureRecognizer:click];
//    
//    UITapGestureRecognizer *click2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btAction2:)];
//    [_imageView2 addGestureRecognizer:click2];
//    
//    UITapGestureRecognizer *click3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btAction3:)];
//    [_imageView3 addGestureRecognizer:click3];
//    
//    UITapGestureRecognizer *click4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btAction4:)];
//    [_imageView4 addGestureRecognizer:click4];
//    
//    UITapGestureRecognizer *click5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btAction5:)];
//    [_imageView5 addGestureRecognizer:click5];
//    
//    UITapGestureRecognizer *click6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btAction6:)];
//    [_imageView6 addGestureRecognizer:click6];
//    
//    
//    self.navigationController.navigationBar.hidden=YES;
//    [self _setTopView];
//    
//    _textField.delegate=self;
//    _textField.delegate=self;
//    _button1.layer.borderColor=[UIColor lightTextColor].CGColor;
//    _button2.layer.borderColor=[UIColor lightTextColor].CGColor;
//    _button3.layer.borderColor=[UIColor lightTextColor].CGColor;
//    _button4.layer.borderColor=[UIColor lightTextColor].CGColor;
//    _button5.layer.borderColor=[UIColor lightTextColor].CGColor;
//    _button6.layer.borderColor=[UIColor lightTextColor].CGColor;
//    _button1.layer.borderWidth=0.8;
//    _button2.layer.borderWidth=0.8;
//    _button3.layer.borderWidth=0.8;
//    _button4.layer.borderWidth=0.8;
//    _button5.layer.borderWidth=0.8;
//    _button6.layer.borderWidth=0.8;
//    
//    
//
//    
//    // Do any additional setup after loading the view from its nib.
//}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//   
//        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 205, KWidth, KHeight-69)];
//        [self.view addSubview: _tableView];
//        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
//            
//            [_textFieldBgView setFrame:CGRectMake(0, 20, KWidth, 49)];
//            [_textFieldBgView setBackgroundColor:[UIColor lightGrayColor]];
//            [_textField setTop:30];
//            [_textField setWidth:KWidth-60];
//            _textField.returnKeyType= UIReturnKeyYahoo;
//            
//            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(KWidth-50,15, 40, 20)];
//            [button setTitle:@"取消" forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
//            [self.textFieldBgView addSubview:button];
//            
//            
//            
//            [_tableView setTop:_textFieldBgView.bottom];
//            _tableView.delegate=self;
//            _tableView.dataSource=self;
//            
//            _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//            
//            
//        } completion:nil];
//    
// 
//
//}
//
//-(void)buttonAction
//{
//    
//   
//    [_tableView setFrame:CGRectMake(0, 700, KWidth, KHeight-69)];
//    _tableView.hidden=YES;
//
//    [_textField setWidth:359];
//  
//    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
//        _textFieldBgView.backgroundColor=[UIColor clearColor];
//        [_textFieldBgView setFrame:CGRectMake(0, 182, KWidth, 49)];
//       
//        [_textField setTop:192];
//     
//       
//        [_textField endEditing:YES];
//        
//        _textField.text=@"";
//    } completion:nil];
//   
//   
//  
//
//}
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    
//  
//        
//    return 1;
//
//
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//   
//   
//        
//    return 3;
//
//
//}
//
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    cell.textLabel.font=[UIFont systemFontOfSize:12];
//    if (indexPath.row==0) {
//    cell.textLabel.text=@"牙龈炎";
//        cell.textLabel.textColor=[UIColor greenColor];
//    }
//    else if(indexPath.row==1)
//    {
//        cell.textLabel.text=@"高血压";
//        cell.textLabel.textColor=[UIColor orangeColor];
//    
//    }
//    else
//    {
//        cell.textLabel.text=@"心血管疾病";
//        cell.textLabel.textColor=[UIColor grayColor];
//    
//    }
//  
//    return cell;
// 
//}
//
//
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//
//    if ([string isEqualToString:@"\n" ]) {
//        if (textField.text.length>0)
//        {
//            DiseaseViewController *vc=[[DiseaseViewController alloc]init];
//            vc.diseaseName=textField.text;
//            _tableView.hidden=YES;
//            self.navigationController.navigationBar.hidden=NO;
//            [self.navigationController pushViewController:vc animated:nil];
//            
//          
//        }
//      
//    }
//    
//    return YES;
//
//
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//     DiseaseViewController *vc=[[DiseaseViewController alloc]init];
//    if (indexPath.row==0) {
//       
//        vc.diseaseName=@"牙龈炎";
//        
//    }
//    else if(indexPath.row==1)
//    {
//    
//        vc.diseaseName=@"高血压";
//    }
//    else if (indexPath.row==2)
//    {
//         vc.diseaseName=@"心血管疾病";
//    
//    }
//
//    _tableView.hidden=YES;
//    self.navigationController.navigationBar.hidden=NO;
//    [self.navigationController pushViewController:vc animated:nil];
//
//
//}
//-(void)pageAction
//{
//    NSInteger xNum=_pc.currentPage;
//    [_scrollView setContentOffset:CGPointMake(xNum*KWidth, -20)];
//
//    
//}
//
//-(void)timeAction
//{
//    _page++;
//    if (_page>=4) {
//        _page=0;
//    }
//    
//    [_scrollView setContentOffset:CGPointMake(_page*KWidth, -20)];
//    
//
//
//}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    
//    _pc.currentPage=scrollView.contentOffset.x/KWidth;
//    
//    
//    
//    
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//
@end
