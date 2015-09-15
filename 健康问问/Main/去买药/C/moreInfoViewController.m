//
//  moreInfoViewController.m
//  健康问问
//
//  Created by Yiqiao on 15/9/5.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "moreInfoViewController.h"
#import "detailModel.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
#import <sqlite3.h>

@interface moreInfoViewController (){
    NSArray *_array;
    UITableView *_tableView;
    CGSize _size;
    detailModel *_infoModel;
}

@end

@implementation moreInfoViewController

- (void)_loadData{
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": @"8ee4f6809b74445b6bccf7d360bb4af5" };
    NSString *urlStr = [@"http://a.apix.cn/yi18/drug/show?id=" stringByAppendingString:_searchId];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
        NSLog(@"%@", error);
    } else {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (dic == NULL) {
            [self _loadData];
        }
        NSDictionary *dictionary = [[NSDictionary alloc]init];
        dictionary = [dic objectForKey:@"yi18"];
            _infoModel.title = [dictionary objectForKey:@"name"];
            _infoModel.image = [dictionary objectForKey:@"image"];
            _infoModel.factory = [dictionary objectForKey:@"factory"];
            _infoModel.message = [dictionary objectForKey:@"message"];
            _infoModel.tipsTAG = [dictionary objectForKey:@"tag"];
            _infoModel.chinaId = [dictionary objectForKey:@"ANumber"];
            _infoModel.categoryName = [dictionary objectForKey:@"categoryName"];
            
            NSNumber *number = [dictionary objectForKey:@"id"];
            _infoModel.idNumber = [[[NSNumberFormatter alloc]init]stringFromNumber:number];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });

    }
    }];
    
    [dataTask resume];
}

#pragma -mark tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 244;
    }
    if (indexPath.row == 1) {
        return 70;
    }
    if (indexPath.row == 2) {
        return _size.height;
    }
    if (indexPath.row == 3){
        return 100;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        if (_infoModel.image.length == 0) {
            return cell;
        }
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, KWidth, 180)];
        [cell addSubview:imageView];
        NSString *urlString = [@"http://www.yi18.net/" stringByAppendingString:_infoModel.image];
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    }
    if (indexPath.row ==1){
        if (_infoModel.title.length == 0) {
            return cell;
        }
        UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, KWidth-10, 40)];
        [cell addSubview:messageLabel];
        NSString *nameStr = [@"药品名称:" stringByAppendingString:_infoModel.title];
        messageLabel.text = nameStr;
        messageLabel.font = [UIFont boldSystemFontOfSize:15];
        UILabel *facLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, KWidth-10, 30)];
        [cell addSubview:facLabel];
        facLabel.font = [UIFont systemFontOfSize:12];
        facLabel.textAlignment = UITextAlignmentRight;
        if (_infoModel.factory.length != 0) {
            NSString *facName = [@"生产商:" stringByAppendingString:_infoModel.factory];
            facLabel.text = facName;
        }else{
            facLabel.text = @"生产商:无信息";
        }
    }
    if (indexPath.row == 2) {
        UILabel *tip = [[UILabel alloc]init];
        [cell addSubview:tip];
        if (_infoModel.tipsTAG.length == 0) {
            return cell;
        }
        tip.text = _infoModel.tipsTAG;
        UIFont *myFont = [UIFont fontWithName:@"Arial" size:14];
        tip.font = myFont;
        [tip setNumberOfLines:0];
        CGSize constraint = CGSizeMake(300, 20000.0f);
        _size = [_infoModel.tipsTAG sizeWithFont:myFont constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];
        [tip setFrame:CGRectMake(10, 0, _size.width, _size.height)];
    }
    if (indexPath.row == 3) {
        if (_infoModel.title.length == 0) {
            return cell;
        }
        UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(25, 10, (KWidth-100)/2, 80)];
        [cell.contentView addSubview:button1];
        button1.backgroundColor = [UIColor redColor];
        [button1 setTitle:@"加入购物车" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button1 addTarget:self action:@selector(buttonAct:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(75+(KWidth-100)/2, 10, (KWidth-100)/2, 80)];
        [cell.contentView addSubview:button2];
        button2.backgroundColor = [UIColor yellowColor];
        [button2 setTitle:@"立即购买" forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return cell;
}

#pragma -mark buy action
- (void)buttonAct:(UIButton*)button{
    NSLog(@"点击");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示" message:@"是否加入购物车" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [_tableView addSubview:alert];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if (_infoModel.title.length == 0) {
         //   NSLog(@"无名字 插入数据库失败");
            return;
        }
        [self insertData:_infoModel.title num:(int)_infoModel.idNumber];
    }
}

#pragma -mark database

- (NSString *)filePath{
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",@"user.db"];
    NSLog(@"%@",path);
    return path;
}
- (void)createDataBase{
    NSString *filePath = [self filePath];
    sqlite3 *pDb = NULL;
    int result = sqlite3_open([filePath UTF8String], &pDb);
    if (result != SQLITE_OK) {
        NSLog(@"open error");
        return;
    }
    NSString *sql = @"create table buylist(id integer, name text)";
    char *error = NULL;
    result = sqlite3_exec(pDb, [sql UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"sqlite3_exec error");
        sqlite3_close(pDb);
        return;
    }
    NSLog(@"创建表成功");
    [self insertData:@"空" num:1000];
    sqlite3_close(pDb);
}
- (void)insertData:(NSString *)name num:(NSInteger)numId{
    NSString *filePath = [self filePath];
    sqlite3 *pDb = NULL;
    sqlite3_stmt *pStmt = NULL;
    
    int result = sqlite3_open([filePath UTF8String], &pDb);
    if (result != SQLITE_OK) {
        NSLog(@"open error");
        return;
    }
    NSString *sql = @"insert into buylist values(?,?)";
    
    result = sqlite3_prepare_v2(pDb, [sql UTF8String], -1, &pStmt, NULL);
    if (result != SQLITE_OK) {
        NSLog(@"sqlite3_prepare_v2 error");
        sqlite3_close(pDb);
        return;
    }
    //data
    sqlite3_bind_int(pStmt, 1, (int)numId);
    const char *charName = [name UTF8String];
    NSLog(@"放入购物车-----%@",name);
    sqlite3_bind_text(pStmt, 2, charName, -1, NULL);
    //add
    sqlite3_step(pStmt);
    //close
    sqlite3_close(pDb);
    sqlite3_finalize(pStmt);
}

- (void)createTable{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _infoModel = [[detailModel alloc]init];
    [self createDataBase];
    [self _loadData];
    [self createTable];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
