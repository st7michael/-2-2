//
//  buyTabletViewController.m
//  健康问问
//
//  Created by Yiqiao on 15/8/28.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "buyTabletViewController.h"
#import <UIKit/UIKit.h>
#import "detailViewController.h"
@interface buyTabletViewController (){
    NSOperationQueue *queue;
    NSArray *_array;
    NSMutableArray *_titleArray;
    UITableView *_tableView;
}

@end

@implementation buyTabletViewController
#pragma -mark BASE
- (void)viewDidAppear:(BOOL)animated{
     self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"药品大全";
    [self _loadData];
    [self addTableView];
}
- (void)_loadData{
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": @"8ee4f6809b74445b6bccf7d360bb4af5" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://a.apix.cn/yi18/drug/drugclass"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (dic == NULL) {
                [self _loadData];
            }
            _titleArray = [[NSMutableArray alloc]init];
            _array = [dic objectForKey:@"yi18"];
            for (NSDictionary *dictionary in _array) {
                NSString *class = [dictionary objectForKey:@"title"];
                [_titleArray addObject:class];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
            
        }
    }];
    [dataTask resume];
}
#pragma -mark tabelView属性
- (void)addTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    detailViewController *detailVC = [[detailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:NO];
    detailVC.searchTitle = _titleArray[indexPath.row];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _titleArray[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
