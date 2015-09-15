//
//  HospitalDetailViewController.m
//  健康问问
//
//  Created by  枫自飘零 on 15/9/5.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "HospitalDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "OfficeViewController.h"
@interface HospitalDetailViewController ()

@end

@implementation HospitalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _hospitalDict=[[NSMutableDictionary alloc]init];
    [self _loadData];
    [self _setNagviationBar];
    
    // Do any additional setup after loading the view from its nib.
}


- (void)_setNagviationBar
{
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(50,0, 150, 40)];
    [button setTitle:@"            查看科室" forState: UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];

    [self.navigationItem setRightBarButtonItem:item];


}
-(void)btAction
{
    OfficeViewController *vc=[[OfficeViewController alloc]initWithNibName:@"OfficeViewController" bundle:[NSBundle mainBundle]];
    vc.hospitalID=_hospitalID;
    
    [self.navigationController pushViewController:vc animated:YES];
    


}

- (void)_loadData
{
    
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": @"3dc8935ea832473e72116ee9f767741f" };
    
    NSString *url=[NSString stringWithFormat:@"http://a.apix.cn/yi18/hospital/show?id=%@",_hospitalID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSArray *array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                        if (array.count==0) {
                                                            [self _loadData];
                                                        }
                                                        else
                                                        {
                                                            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                            _hospitalDict=[dict objectForKey:@"yi18"];
                                                       
                                                        }
                                                        
                                                    }
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [self setData];
                                                    });
   
                                                }];
  
    [dataTask resume];
    
    
    


}
- (void)setData
{
    if ([_hospitalDict objectForKey:@"name"]!=nil) {
        _titleLabel.text=[_hospitalDict objectForKey:@"name"];
        _levelLabel.text=[_hospitalDict objectForKey:@"level"];
       
        _mtypeLabel.text=[_hospitalDict objectForKey:@"mtype"];
        
        NSString *summary=[_hospitalDict
                           objectForKey:@"summary"];

        NSString *trimmendSummary=[summary stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        NSString *finalSummary=[trimmendSummary stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
        
        _summaryTextView.text=finalSummary;
        if ([[_hospitalDict objectForKey:@"logo"] isEqualToString:@"img/hospital/default.jpg"]) {
            [_iconView setImage:[UIImage imageNamed:@"hospital.jpg"]];
        }
        else
        {
        NSString *urlStr=[NSString stringWithFormat:@"http://www.1ccf.com//%@",[_hospitalDict objectForKey:@"logo"]];
        [_iconView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
            
        }
        _telLabel.text=[_hospitalDict objectForKey:@"tel"];
        _addressLabel.text=[_hospitalDict objectForKey:@"address"];
    }
    
    


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
