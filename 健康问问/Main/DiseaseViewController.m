//
//  DiseaseViewController.m
//  健康问问
//
//  Created by  枫自飘零 on 15/9/11.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "DiseaseViewController.h"
#import "Common.h"
#import "DiseaseDetailViewController.h"
@interface DiseaseViewController ()

@end

@implementation DiseaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,KWidth, KHeight) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    [self _loadData];
    
    
    // Do any additional setup after loading the view.
}

-(void)_loadData
{
    _array=[[NSMutableArray alloc]init];
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": @"ceb4b501110245135198f2f5cb5c76bf" };
    
    NSString *str=[NSString stringWithFormat:@"http://a.apix.cn/yi18/disease/search?keyword=%@",_diseaseName];
      NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)str, NULL, NULL,  kCFStringEncodingUTF8 ));
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedString]
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
                                                       
                                                       NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                      if (dict==nil) {
                                                          [self _loadData];
                                                        }
                                                        for (NSDictionary *dataDict in [dict objectForKey:@"yi18"]) {
                                                            [_array addObject:dataDict];
                                            
                                                            
                                                        }
                                                    }
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [_tableView reloadData];
                                                     
                                                    });
                                                }];
    [dataTask resume];
    


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dict=_array[indexPath.row];
    NSString *title=[dict objectForKey:@"title"];
    NSString *title1=[title stringByReplacingOccurrencesOfString:@"<font color=\"red\">" withString:@""];
    NSString *title2=[title1 stringByReplacingOccurrencesOfString:@"</font>" withString:@""];
  
    cell.textLabel.text=title2;
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiseaseDetailViewController *vc=[[DiseaseDetailViewController alloc]initWithNibName:@"DiseaseDetailViewController" bundle:[NSBundle mainBundle]];
    vc.dict=_array[indexPath.row];
    [self.navigationController pushViewController:vc animated:nil];
    

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
