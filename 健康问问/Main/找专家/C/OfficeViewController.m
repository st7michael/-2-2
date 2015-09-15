//
//  OfficeViewController.m
//  健康问问
//
//  Created by  枫自飘零 on 15/9/5.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "OfficeViewController.h"
#import "OfficeTableViewCell.h"
#import "UIViewExt.h"
@interface OfficeViewController ()

@end

@implementation OfficeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadData];
    [self setTableView];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)_loadData
{
    _officeArray=[[NSMutableArray alloc]init];
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": @"3dc8935ea832473e72116ee9f767741f" };
    
    NSString *urlStr=[NSString stringWithFormat:@"http://a.apix.cn/yi18/hospital/feature?id=%@",_hospitalID];
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
                                                        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                        if (dict==nil) {
                                                            [self _loadData];
                                                        }
                                                        else
                                                        {
                                                            _officeArray=[dict objectForKey:@"yi18"];
                                                        }
                                                       
                                                    }
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [_tableView reloadData];
                                                    });
                                                }];
    [dataTask resume];


}

- (void)setTableView
{
    _tableView.dataSource=self;
    _tableView.delegate=self;
    UINib *nib=[UINib nibWithNibName:@"OfficeTableViewCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _officeArray.count;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OfficeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dict=_officeArray[indexPath.row];
    cell.nameLabel.text=[dict objectForKey:@"name"];
    cell.textView.text=[dict objectForKey:@"message"];
    NSString *text=[dict objectForKey:@"message"];
    
    CGFloat height=(text.length/24+1)*20+10;

    cell.textView.height=height;
    

    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dict=_officeArray[indexPath.row];
    NSString *text=[dict objectForKey:@"message"];
    
    CGFloat height=(text.length/24+1)*20+40;
    
    
    
    
    return height;


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
