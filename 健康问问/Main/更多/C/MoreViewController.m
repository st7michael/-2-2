
//
//  MoreViewController.m
//  健康问问
//
//  Created by 冯颐平 on 15/9/10.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "MoreViewController.h"
#import "Common.h"
#import "ImageSharedViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatIcon];
    // Do any additional setup after loading the view.
}

- (void)creatIcon
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0,kNagvHeight+10, 100, 100)];
    btn.backgroundColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:@"desk_top_more_pic3_@3x.png"]];
    [btn addTarget:self action:@selector(btnAct) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    UILabel *btnName = [[UILabel alloc]initWithFrame:CGRectMake(btn.center.x-20, kNagvHeight+100, 100, 30)];
    btnName.text = @"图片分享";

    [self.view addSubview:btnName];
}
- (void)btnAct
{
    ImageSharedViewController *vc = [[ImageSharedViewController alloc]init];
    self.navigationItem.title = @"图片分享";
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
