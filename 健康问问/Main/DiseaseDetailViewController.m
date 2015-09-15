//
//  DiseaseDetailViewController.m
//  健康问问
//
//  Created by  枫自飘零 on 15/9/11.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "DiseaseDetailViewController.h"
#import "UIImageView+WebCache.h"
@interface DiseaseDetailViewController ()

@end

@implementation DiseaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadData];
    
   
    // Do any additional setup after loading the view from its nib.
}

-(void)_setData
{
    NSString *title=[_dict objectForKey:@"title"];
    NSString *title1=[title stringByReplacingOccurrencesOfString:@"<font color=\"red\">" withString:@""];
    NSString *title2=[title1 stringByReplacingOccurrencesOfString:@"</font>" withString:@""];
    _titleLabel.text=title2;
    
    NSString *str=[_dict objectForKey:@"img"];
    NSString *urlStr=[NSString stringWithFormat:@"http://www.1ccf.com//%@",str];
    
    
    [_diseaseImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    
     NSString *context=[_detailDict objectForKey:@"summary"];
     context=[context stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    
    context=[context stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    context=[context stringByReplacingOccurrencesOfString:@"&middot" withString:@""];
    
    NSString *durgText=[_detailDict objectForKey:@"drugText"];
    durgText=[durgText stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    
    durgText=[durgText stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    durgText=[durgText stringByReplacingOccurrencesOfString:@"&middot" withString:@""];
    durgText=[NSString stringWithFormat:@"\n\n治疗方法%@",durgText];

    context=[ context stringByAppendingString:durgText];
    _contextView.text=context;
    


}
-(void)_loadData
{
    _detailDict=[[NSDictionary alloc]init];
    NSString *idStr=[_dict objectForKey:@"id"];
    NSLog(@"%@",idStr);
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": @"ceb4b501110245135198f2f5cb5c76bf" };
    NSString *urlStr=[NSString stringWithFormat:@"http://a.apix.cn/yi18/disease/show?id=%@",idStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]
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
                                                        NSDictionary *dicts=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                        if (dicts==nil) {
                                                            [self _loadData];
                                                        }
                                                  
                                                        _detailDict=[dicts objectForKey:@"yi18"];
                                                    
                                                        
                                                    }
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [self _setData];
                                                    });
                                                }];
    [dataTask resume];
    


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
