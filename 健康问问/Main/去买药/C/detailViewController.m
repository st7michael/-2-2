//
//  detailViewController.m
//  健康问问
//
//  Created by Yiqiao on 15/9/4.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "detailViewController.h"
#import "model.h"
#import "UIImageView+WebCache.h"
#import "moreInfoViewController.h"
#import "Common.h"
@interface detailViewController (){
    UITableView *_tableView;
    NSArray *_array;
    NSMutableArray *_modelArray;
    
}

@end

@implementation detailViewController
#pragma -mark TABLEVIEW
- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    while (cell.contentView.subviews.lastObject!=nil) {
      [ (UIView*)cell.contentView.subviews.lastObject removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidth, 70)];
    
    UIImageView *_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 55, 55)];
    model *cellModel = [[model alloc]init];
    cellModel = _modelArray[indexPath.row];
    NSString *urlString = [@"http://www.yi18.net/" stringByAppendingString:cellModel.image];
    if ([urlString isEqualToString:@"http://www.yi18.net/img/drug/default.jpg"]) {
        _imageView.image = [UIImage imageNamed:@"med1111"];
    }else{
        [_imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    }
    [baseView addSubview:_imageView];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, 200, 30)];
    NSString *strNew = [cellModel.title stringByReplacingOccurrencesOfString:@"<font color=\"red\">" withString:@""];
    NSString *str = [strNew stringByReplacingOccurrencesOfString:@"</font>" withString:@""];
    titleLabel.text = str;
    titleLabel.tag=3;
    [baseView addSubview:titleLabel];
    [cell.contentView addSubview:baseView];
    return cell;
}

- (void)_loadData{
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": @"8ee4f6809b74445b6bccf7d360bb4af5" };
    
    NSString *urlStr = [@"http://a.apix.cn/yi18/drug/search?page=1&keyword=" stringByAppendingString:_searchTitle];
    NSString *encodedUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)urlStr, NULL, NULL, kCFStringEncodingUTF8));
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
        NSLog(@"%@", error);
    }
    else {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
     
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _array = [dic objectForKey:@"yi18"];
        _modelArray = [[NSMutableArray alloc]init];
        
        if (dic == NULL) {

            [self _loadData];
        }
        for (NSDictionary *dictionary in _array) {
            model *infoModel = [[model alloc]init];
            infoModel.title = [dictionary objectForKey:@"title"];
            infoModel.image = [dictionary objectForKey:@"img"];
            NSNumber *number = [dictionary objectForKey:@"id"];
            infoModel.idNumber = [[[NSNumberFormatter alloc]init]stringFromNumber:number];
            [_modelArray addObject:infoModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    }
    }];
    [dataTask resume];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    moreInfoViewController *moreVC = [[moreInfoViewController alloc]init];
    [self.navigationController pushViewController:moreVC animated:NO];
    model *model = _modelArray[indexPath.row];
    moreVC.searchId = model.idNumber;
  //  NSLog(@"select num: %@",moreVC.searchId);
}

- (void)test{
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": @"8ee4f6809b74445b6bccf7d360bb4af5" };
    
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://a.apix.cn/yi18/drug/search?keyword=1&page=1"]
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
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
                                                        
                                                        
                                                    }
                                                }];
    [dataTask resume];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadData];
    [self createTableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
