
//
//  ImageSharedViewController.m
//  健康问问
//
//  Created by 冯颐平 on 15/9/10.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "ImageSharedViewController.h"
#import<Foundation/Foundation.h>
#import "ImageSharedViewController.h"
#import "ImageShareModel.h"
#import "Common.h"
#import "ImageShareTableViewCell.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "MJRefresh.h"
@interface ImageSharedViewController ()
{
    UITableView *ImageTableView;
    MBProgressHUD *hud;
    NSInteger index;
}
@end

@implementation ImageSharedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    index = 1;
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [self loadData];
    [self creatTableView];
    // Do any additional setup after loading the view.
}
- (void)creatTableView
{
    ImageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight) style:UITableViewStylePlain];
    ImageTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    ImageTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    ImageTableView.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        index++;
        [self loadData];
    }];
    //ImageTableView.userInteractionEnabled = NO;
    ImageTableView.delegate =self;
    ImageTableView.dataSource = self;

    
    UINib *nib = [UINib nibWithNibName:@"ImageShareTableViewCell" bundle:nil];
    [ImageTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:ImageTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.ImageShareArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ImageShareModel *model  =   self.ImageShareArray[indexPath.row];
    cell.model = model;
    return cell;
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 435 ;
}

- (void)loadData
{

    hud.hidden = NO;
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": @"c5a0637332b04e057b70d6356286e3b4" };
    NSString *urlStirng =  [NSString stringWithFormat:@"http://a.apix.cn/huceo/meinv/?num=10&page=%ld",index];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStirng]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                        
                                                        [ImageTableView.header endRefreshing];
                                                        hud.hidden = YES;
                                                        [self loadData];
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        
                                                        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                        if(dic == NULL)
                                                        {
                                                            [self loadData];
                                                        }
                                                        NSLog(@"%@",dic);

                                                        [dic removeObjectForKey:@"code"];
                                                        [dic removeObjectForKey:@"msg"];
                                                        if(_ImageShareArray.count == 0)
                                                        {
                                                            self.ImageShareArray = [[NSMutableArray alloc]init];
                                                            for(int i = 0; i<10; i++)
                                                            {

                                                                NSDictionary *dic1 = [dic objectForKey:@(i).stringValue];
                                                                ImageShareModel *model = [[ImageShareModel alloc]init];
                                                                model.Imagedescrib = [dic1 objectForKey:@"description"];
                                                                model.Imagetitle = [dic1 objectForKey:@"title"];
                                                                model.ImagepicUrl = [dic1 objectForKey:@"picUrl"];
                                                                model.Imageurl = [dic1 objectForKey:@"url"];
                                                                [self.ImageShareArray addObject:model];
                                                                
                                                            }
                                                        }
                                                        else
                                                        {

                                                            for(int i = 0; i<10 ; i++)
                                                            {
                                                                
                                                                NSDictionary *dic1 = [dic objectForKey:@(i).stringValue];
                                                                ImageShareModel *model = [[ImageShareModel alloc]init];
                                                                model.Imagedescrib = [dic1 objectForKey:@"description"];
                                                                model.Imagetitle = [dic1 objectForKey:@"title"];
                                                                model.ImagepicUrl = [dic1 objectForKey:@"picUrl"];
                                                                model.Imageurl = [dic1 objectForKey:@"url"];
                                                                [self.ImageShareArray addObject:model];
                                                                
                                                            }
                                                        
                                                        }
                                                        [ImageTableView.header endRefreshing];
                                                        [ImageTableView.footer endRefreshing];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [ImageTableView reloadData];
                                                            hud.hidden = YES;
                                                            [self.view setNeedsDisplay];
                                                        });
                                                    }
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
