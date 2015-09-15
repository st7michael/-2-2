//
//  SmartViewController.m
//  健康问问
//
//  Created by  枫自飘零 on 15/9/6.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "SmartViewController.h"
#import "SmartCell.h"
#import "DealText.h"
#import "UIViewExt.h"

@interface SmartViewController ()

@end

@implementation SmartViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = YES;
    _textField.delegate=self;
    [self.view addGestureRecognizer:tapGr];
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyWillShow) name:UITextFieldTextDidBeginEditingNotification object:nil];
     [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(keyboardWillHiden) name:UIKeyboardWillHideNotification object:nil];
    
    self.navigationController.navigationBarHidden=NO;
    [self setTableView];
    _array=[[NSMutableArray alloc]init];
    NSDictionary *dic=@{@"text":@"很高兴为您服务",
                        @"isUser":@"0"};
    [_array addObject:dic];
    [_postButton addTarget:self action:@selector(postAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)keyboardWillHiden
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        [_bgView setTop:622];
        [_textField resignFirstResponder];
    } completion:nil];

}
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
   
        [_bgView setTop:622];
        [_textField resignFirstResponder];
        [_tableView setHeight:547];
    } completion:nil];
    

}

- (void)keyWillShow
{
  [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
      [self.view bringSubviewToFront:_bgView];
      [_bgView setTop:340];
      if (_array.count>0) {
          [_tableView setHeight:280];
          NSIndexPath * indexPath=[NSIndexPath indexPathForRow:_array.count-1 inSection:0];
         [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
      }
      

      
  } completion:nil];
    
   
    
}
-(void)postAction
{
    if (_textField.text.length!=0) {
        NSDictionary *dic=@{@"text":_textField.text,
                            @"isUser":@"1"};
        [_array addObject:dic];
        [_tableView reloadData];
        NSIndexPath * indexPath=[NSIndexPath indexPathForRow:_array.count-1 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        _text=_textField.text;
        _textField.text=@"";
        
    
        [self performSelector:@selector(_loadData) withObject:nil afterDelay:1];
        
    }
    
}


- (void)_loadData
{

    NSString *httpUrl = @"http://apis.baidu.com/turing/turing/turing";
   
    NSString *httpArg=[NSString stringWithFormat:@"key=879a6cb3afb84dbf4fc84a1df2ab7319&info=%@",_text];
 
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)httpArg, NULL, NULL,  kCFStringEncodingUTF8 ));
    [self request: httpUrl withHttpArg: encodedString];


}
-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"bf0987d150048d038132fc203319961b" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                  NSMutableDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                   [dic setValue:@"0" forKey:@"isUser"];
                                   NSLog(@"%@",dic);
                                   [_array addObject:dic];
                               }
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   [_tableView reloadData];
                                   NSIndexPath * indexPath=[NSIndexPath indexPathForRow:_array.count-1 inSection:0];
                                   [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
                                
                                   
                                   
                               });
                           }];
}
- (void)setTableView
{
    _tableView.dataSource=self;
    _tableView.delegate=self;
    UINib *nib=[UINib nibWithNibName:@"SmartCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"smartCell"];
    

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
    SmartCell *cell=[tableView dequeueReusableCellWithIdentifier:@"smartCell"];
    NSDictionary *dic=_array[indexPath.row];
    cell.dic=dic;
    
   
    
    return cell;
    


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=_array[indexPath.row];
    NSString *text=[dic objectForKey:@"text"];
   CGFloat textHeight= [DealText getTextHeightwihtFont14:text];
    CGFloat height=textHeight+50;
    
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
