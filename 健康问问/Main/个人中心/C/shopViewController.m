//
//  shopViewController.m
//  健康问问
//
//  Created by Yiqiao on 15/9/8.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "shopViewController.h"
#import <sqlite3.h>
#import "model.h"
@interface shopViewController (){
    UITableView *_tableView;
    NSMutableArray *_medArray;
}
@end

@implementation shopViewController
#pragma -mark database
- (NSString *)filePath{
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",@"user.db"];
    NSLog(@"%@",path);
    return path;
}

- (void)deleteData:(NSString*)numId{
    
   // NSString *sql =[@"delete from buylist where name =" stringByAppendingString:name];
    NSString *filePath = [self filePath];
    sqlite3 *pDb = NULL;
    sqlite3_stmt *pStmt = NULL;
    
    int result = sqlite3_open([filePath UTF8String], &pDb);
    if (result != SQLITE_OK) {
        NSLog(@"open error");
        return;
    }

    NSString *str = [NSString stringWithFormat:@"%@",numId];
    
    NSString *sql =[@"delete from buylist where id = " stringByAppendingString:str];
    result = sqlite3_prepare_v2(pDb, [sql UTF8String], -1, &pStmt, NULL);
    if (result != SQLITE_OK) {
        NSLog(@"sqlite3_prepare_v2 error");
        sqlite3_close(pDb);
        return;
    }
    //data
    sqlite3_bind_int(pStmt, 1, (int)numId);
   
    NSLog(@"%@",numId);
   // NSLog(@"trans-%@",(NSString*)numId);
    //add
    sqlite3_step(pStmt);
    //close
    sqlite3_close(pDb);
    sqlite3_finalize(pStmt);

}

- (void)queryData{
    NSString *filepath = [self filePath];
    sqlite3 *pDb = NULL;
    sqlite3_stmt *pStmt = NULL;
    int result = sqlite3_open([filepath UTF8String], &pDb);
    if (result != SQLITE_OK) {
        NSLog(@"open error");
        return;
    }
    NSString *sql = @"select * from buylist";
    result = sqlite3_prepare_v2(pDb, [sql UTF8String], -1, &pStmt, NULL);
    if (result != SQLITE_OK) {
        NSLog(@"sqlite3_prepare_v2 error");
        sqlite3_close(pDb);
        return;
    }
    int hasData = sqlite3_step(pStmt);
    
    while (hasData == SQLITE_ROW) {

        const unsigned char *name = sqlite3_column_text(pStmt, 1);
        int idNumber = sqlite3_column_int(pStmt, 0);
        hasData = sqlite3_step(pStmt);
        model *medModel = [[model alloc]init];
        medModel.title = [[NSString alloc]initWithUTF8String:(const char*)name];
    //    NSLog(@"%@",medModel.title);
        medModel.idNumber = [[NSString alloc]initWithFormat:@"%d",idNumber];
      //  NSLog(@"+++++%@",medModel.idNumber);
        [_medArray addObject:medModel];
        
    }
    [_medArray removeLastObject];
    sqlite3_close(pDb);
    sqlite3_finalize(pStmt);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
}
#pragma -mark tableview属性
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//no more than 100
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _medArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    while (cell.contentView.subviews.lastObject!=nil) {
        [ (UIView*)cell.contentView.subviews.lastObject removeFromSuperview];
    }
    if (_medArray.count == 0) {
        return cell;
    }
    if (indexPath.row>=_medArray.count) {
        return cell;
    }
    model *d = [[model alloc]init];
    d = _medArray[indexPath.row];
//    NSLog(@"%@",d.title);
//    NSLog(@"%ld",indexPath.row);
    cell.textLabel.text = d.title;
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        model *m = [[model alloc]init];
        m = _medArray[indexPath.row];
        [self deleteData:m.idNumber];
        //NSLog(@"------%@",m.idNumber);
        [_medArray removeObjectAtIndex:indexPath.row];
        [_tableView reloadData];
    }
}

#pragma -mark BASE
- (void)createViews{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"
     ];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _medArray = [[NSMutableArray alloc]init];
    [self createViews];
    [self queryData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
