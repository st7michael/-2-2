//
//  NewsViewController.m
//  健康问问
//
//  Created by 冯颐平 on 15/9/6.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "NewsViewController.h"
#import <Foundation/Foundation.h>
#import "Common.h"
#import "newsTableViewCell.h"
#import "newsModel.h"
#import "NewsDetailViewController.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
@interface NewsViewController ()
{
    UIScrollView *scrollView;
    UIScrollView *newsView;
    UITableView *news;
    NSString *selectString;
    UIImageView *selectImage;
    NSMutableArray *btncenter;
    MBProgressHUD *hud;
    NSInteger index;
}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    index = 1;
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    UIBarButtonItem *backbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_left@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAct)];
    self.navigationItem.leftBarButtonItem = backbtn;
    self.newsIndex =0;
    [self _creatButtonView];
    [self creatTableView];
    [self loadData];
    // Do any additional setup after loading the view.
}
- (void)backAct
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)_creatButtonView
{
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, kNagvHeight, KWidth, 50)];
    buttonView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"decktop_search_background@3x.png"]];
    
    
    [self.view addSubview:buttonView];
    
    selectImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, KWidth/5 -10, 50)];
    [selectImage setImage:[UIImage imageNamed:@"clinic_title@2x.png"]];
    [buttonView addSubview:selectImage];
    
    
    NSArray *imgNames = @[
                          @"热点",
                          @"疾病",
                          @"生殖",
                          @"心理",
                          @"药品",
                          ];
    btncenter = [[NSMutableArray alloc]init];
    for( int i = 0; i <5 ; i++)
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(5+i*KWidth/5, 0 , KWidth/5 -10, 50)];
    //    btn.backgroundColor = [UIColor clearColor];
      //  btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"anniu3-@2x.png"]];
        btn.layer.borderWidth=1;
        btn.layer.borderColor=[UIColor lightGrayColor].CGColor;
        
        btn.tag = i;
        [btn setTitle:imgNames[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchDown];
        
        [buttonView addSubview:btn];
        

        [btncenter addObject:btn];
        
    }
    [self creatNewsView];
    
}
- (void)btnAct:(UIButton*)btn
{
    if(self.newsIndex != btn.tag)
    {
        index = 1;
    }

    [newsView setContentOffset:CGPointMake(KWidth*btn.tag,0) animated:YES];
    self.newsIndex = btn.tag;
    [self loadData];
//    if(self.newsIndex != 0)
//    {
        [news removeFromSuperview];
        [UIView animateWithDuration:0.2 animations:^{
        
            NSLog(@"%f",btn.center);
            //37.5 112.5 187.5 262.5 337.5
            selectImage.center = btn.center;
        
        }];

        [self creatTableView];
        [_newsMtArray removeAllObjects];
        

//    }


    
    
}
- (void)creatNewsView
{
    newsView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNagvHeight+50, KWidth, KHeight-kNagvHeight-50)];
    newsView.contentSize =CGSizeMake(KWidth*5, KHeight-kNagvHeight-50);
    newsView.delegate = self;
    newsView.pagingEnabled = YES;
    newsView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:newsView];
    

}

- (void)creatTableView
{
    news = [[UITableView alloc]initWithFrame:CGRectMake(KWidth*self.newsIndex, 0, KWidth, KHeight-kNagvHeight-50)];
    news.backgroundColor = [UIColor clearColor];
    news.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        

        
        [self loadData];
    }];
    news.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        index ++;
        [self loadData];
    }];
    news.delegate = self;
    news.dataSource = self;
//    if(self.newsIndex == 0)
//    {
//        //news.backgroundColor = [UIColor blueColor];
//        selectString =@"热点";
//        
//    }
//    else if(self.newsIndex == 1)
//    {
//        //news.backgroundColor = [UIColor yellowColor];
//        selectString =@"疾病";
//    }
//    else if(self.newsIndex == 2)
//    {
//        selectString =@"生殖";
//    }
//    else if(self.newsIndex == 3)
//    {
//        selectString =@"心理";
//    }
//    else if(self.newsIndex == 4)
//    {
//        selectString =@"药品";
//    
//    }
    UINib *nib = [UINib nibWithNibName:@"newsTableViewCell" bundle:nil];
    [news registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [newsView addSubview:news];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.newsMtArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    newsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    newsModel *model = self.newsMtArray[indexPath.row];
    [cell setModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData
{
    
    if(self.newsIndex == 0)
    {
        //news.backgroundColor = [UIColor blueColor];
        selectString =@"热点";
        
    }
    else if(self.newsIndex == 1)
    {
        //news.backgroundColor = [UIColor yellowColor];
        selectString =@"疾病";
    }
    else if(self.newsIndex == 2)
    {
        selectString =@"生殖";
    }
    else if(self.newsIndex == 3)
    {
        selectString =@"心理";
    }
    else if(self.newsIndex == 4)
    {
        selectString =@"药品";
        
    }
    hud.hidden = NO;
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": @"a27793b5102842127d333606f5b829ea" };
    NSString *urlStr = [[NSString alloc]init];
    if(selectString == nil&&index== 1)
    {
        urlStr = @"http://a.apix.cn/yi18/news/search?page=1&limit=20&keyword=热点";
    }
    else
    {
        NSLog(@"%@",selectString);
        urlStr = [NSString stringWithFormat:@"http://a.apix.cn/yi18/news/search?page=%ld&limit=20&keyword=%@",index,selectString];
    }
   
    NSString *encodedUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)urlStr, NULL, NULL, kCFStringEncodingUTF8));

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (error)
            {
                NSLog(@"%@", error);
                
                
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"error" message:@"time out" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"sure", nil];
//                
//                [alertView show];
                //hud.hidden = YES;
                //[news.header endRefreshing];
                [self loadData];
            
            }
        else
            {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                NSLog(@"%@", httpResponse);
                
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if(dic == NULL)
                {
                    [self loadData];
                }

               // NSLog(@"%@",dic);
                NSArray *newArray = [dic objectForKey:@"yi18"];
                if(self.newsMtArray.count == 0)
                {
                    self.newsMtArray = [[NSMutableArray alloc]init];
                    for(NSDictionary *newDic in newArray)
                    {
                        newsModel *model = [[newsModel alloc]init];
                        model.newsTitle =[newDic objectForKey:@"title"];
                        model.newsContent = [newDic objectForKey:@"content"];
                        model.imageName = [newDic objectForKey:@"img"];
                        [_newsMtArray addObject:model];
                    }
                }
                else
                {
                    for(NSDictionary *newDic in newArray)
                    {
                        newsModel *model = [[newsModel alloc]init];
                        model.newsTitle =[newDic objectForKey:@"title"];
                        model.newsContent = [newDic objectForKey:@"content"];
                        model.imageName = [newDic objectForKey:@"img"];
                        [_newsMtArray addObject:model];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{

                    [news reloadData];
                    hud.hidden =YES;
                    [news.header endRefreshing];
                    [news.footer endRefreshing];
                    [self.view setNeedsDisplay];
                });

            }
        

    
      
                                                }];
    

   
    
    
    [dataTask resume];

}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if(scrollView == newsView)
//    {
//        if(self.newsIndex !=0 )
//        {
//                [self loadData];
//        }
//    }
//}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{



}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset


{
    

//    self.newsIndex = x/375;
//

//    news.frame = CGRectMake(KWidth*self.newsIndex, 0, KWidth, KHeight-kNagvHeight);
    if(scrollView == newsView)
    {
  //      NSLog(@"%f",scrollView.contentOffset.x);
//        if(newsView.contentOffset.x == 375||newsView.contentOffset.x == 375*2||scrollView.contentOffset.x == 375*3||newsView.contentOffset.x == 375*4||newsView.contentOffset.x == 375*0)
        if(targetContentOffset->x == 375||targetContentOffset->x == 375*2||targetContentOffset->x == 375*3||targetContentOffset->x == 375*4||targetContentOffset->x == 375*0)
        {
            index = 1;
            CGFloat x = targetContentOffset->x;
            NSLog(@"pian yi =%lf",x);
            self.newsIndex = x/375;
            
            [self loadData];
            [news removeFromSuperview];
//            CGFloat x = targetContentOffset->x;
//            NSLog(@"pian yi =%lf",x);
//            self.newsIndex = x/375;
            
                //37.5 112.5 187.5 262.5 337.5
            
            UIButton *btn = btncenter[self.newsIndex];
            [UIView animateWithDuration:0.2 animations:^{
                

                //37.5 112.5 187.5 262.5 337.5
                selectImage.center = btn.center;
                
            }];

            
            NSLog(@"%ld",(long)self.newsIndex);
            [self creatTableView];
            [_newsMtArray removeAllObjects];
        }
    
    }

    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self.newsMtArray[indexPath.row]);
    NewsDetailViewController *vc = [[NewsDetailViewController alloc]init];
    vc.navigationItem.title = selectString;

    vc.model = _newsMtArray[indexPath.row];
    news.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
    

}
- (void)viewWillAppear:(BOOL)animated
{
    index = 1;
    news.hidden = NO;
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
