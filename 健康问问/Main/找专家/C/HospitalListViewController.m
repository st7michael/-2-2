//
//  HospitalListViewController.m
//  健康问问
//
//  Created by  枫自飘零 on 15/8/31.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "HospitalListViewController.h"
#import "UIViewExt.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
#import "HospitalListCell.h"
#import "hospitalModel.h"
#import "MJRefresh.h"
#import "HospitalDetailViewController.h"
@interface HospitalListViewController ()

@end

@implementation HospitalListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    index=0;
    [self setSelectImage];
    _pickerView.delegate=self;
    _pickerView.dataSource=self;
    _pickerView.showsSelectionIndicator=YES;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    UINib *nib=[UINib nibWithNibName:@"HospitalListCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    _hospitalID=@"2";
    _page=1;

    
     
  
    

    [self _loadData];
    

    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //[self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    
    
    
   
    // Do any additional setup after loading the view from its nib.
}
// ------上拉加载
- (void)loadMoreData
{
    _page++;

    _isReshData=NO;
    [self _loadHospitalData];
 
    
}
-(void)_loadData
{
    
    _provinceArray=[[NSMutableArray alloc]init];
    _cityArray=[[NSMutableArray alloc]init];
    _hospitaclArray=[[NSMutableArray alloc]init];
  
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": @"3dc8935ea832473e72116ee9f767741f" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://a.apix.cn/yi18/hospital/province?type=all"]
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
                                                      
                                                     
                                                        NSArray *yi18Array=[dict valueForKey:@"yi18"];
                                                        for (NSDictionary *proDict in yi18Array) {
                                                            
                                                            
                                                            NSString *province=[proDict objectForKey:@"province"];
                                                          
                                                            NSArray *list=[proDict objectForKey:@"list"];
                                                            [_provinceArray addObject:province];
                                                            [_cityArray addObject:list];
                                                           
                                                        }
                                                        if (_provinceArray.count==0) {
                                                            [self _loadData];
                                                        }
                                                        _isReshData=YES;
                                                        
                                                        
                                                    }
                                                    
                                               
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                   
                                                    [_pickerView reloadAllComponents];
                                                    
                                                });
                                                    
                                                }];
    [dataTask resume];
    
    [self _loadHospitalData];


}
-(void)_loadHospitalData
{
    if (_isReshData==YES) {
        _hospitaclArray=[[NSMutableArray alloc]init];
    }

    
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": @"3dc8935ea832473e72116ee9f767741f" };
    
    NSString *str=[NSString stringWithFormat:@"http://a.apix.cn/yi18/hospital/list?id=%@&page=%li",_hospitalID,_page];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]
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
                                                      
                                                            [self _loadHospitalData];
                                                            
                                                        }
                                                      

                                                        [_hospitaclArray addObjectsFromArray:[dict objectForKey:@"yi18"]];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            
                                                            [self.tableView reloadData];
                                                            [self.view setNeedsLayout];
                                                            
                                                        });
  
                                                     
                                                        
                                                    }
                                                 
                                                    
                                                }];
    
  

    [dataTask resume];
    [self.tableView.footer endRefreshing];
    

    
    

}
-(void)setSelectImage
{
    _selectImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addRessAction:)];
    [_selectImage addGestureRecognizer:ges];
    [_selectButton setTitleColor:[UIColor colorWithRed:0 green:0.6 blue:0 alpha:0.8] forState:UIControlStateHighlighted];
    
    [_tableView setTop:86];
    [self.view bringSubviewToFront:_selectButton];
    [self.view bringSubviewToFront:_selectImage];

}

#pragma  ----------------------------------deal with tableView-----------------------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _hospitaclArray.count;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HospitalListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dict=_hospitaclArray[indexPath.row];
    NSString *str=[dict objectForKey:@"logo"];
    if ([str isEqualToString:@"img/hospital/default.jpg"]) {
        [cell.iconView setImage:[UIImage imageNamed:@"hospital.jpg"]];
    }
    else
    {
        NSString *urlStr=[NSString stringWithFormat:@"http://www.1ccf.com//%@",str];
        [cell.iconView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
    
    
    }
    cell.addressLable.text=[dict objectForKey:@"address"];
    cell.titleLable.text=[dict objectForKey:@"name"];
    
    return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HospitalDetailViewController *vc=[[HospitalDetailViewController alloc]initWithNibName:@"HospitalDetailViewController" bundle:[NSBundle mainBundle]];
    NSDictionary *dict=_hospitaclArray[indexPath.row];
    vc.hospitalID=[dict objectForKey:@"id"];
  
    [self.navigationController pushViewController:vc animated:YES];



}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 86;



}

- (IBAction)addRessAction:(id)sender {
    _isSelect=!_isSelect;
    if (_isSelect==YES) {
        [_selectImage setImage:[UIImage imageNamed:@"CartThrow@3x.png"]];
        [_selectButton setTitleColor:[UIColor colorWithRed:0 green:0.6 blue:0 alpha:0.8] forState:UIControlStateNormal];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        [_pickerView setTop:19];
        [_tableView setTop:160];
        [UIView commitAnimations];
        
    
    }
    else
    {
        [_selectImage setImage:[UIImage imageNamed:@"arrow_pressed@3x.png"]];
         [_selectButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        [_tableView setTop:86];
        [_pickerView setTop:-80];
        [UIView commitAnimations];
        
    
    }
    
    
}

#pragma ------------------------dealwith pickView------------------------------------------------

- (CGFloat)pickerView:(UIPickerView *)pickerView
rowHeightForComponent:(NSInteger)component
{
    return 18;
    
    


}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 2;


}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger num=0;
    
    if (component==0) {
        num=_provinceArray.count;
    }
    else
    {
        if (_cityArray.count>0) {
            NSArray *array=[[NSArray alloc]init];
            array=_cityArray[index];
            num=array.count;
        }
    }
    

 
    return num;
}




-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(KWidth/2-30,0, 20, 20)];
    [imageView setImage:[UIImage imageNamed:@"arrow@2x.png"]];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, KWidth/2-20, 20)];
    [label addSubview:imageView];
    
    [label setFont:[UIFont systemFontOfSize:15]];
    label.textAlignment=NSTextAlignmentCenter;
    if (component==0) {
        label.text=_provinceArray[row];
        [label addSubview:imageView];
    }
    else if(component==1)
    {
        NSArray *array=[[NSArray alloc]init];
        array=_cityArray[index];
        NSDictionary *dict=array[row];
        
        
        label.text=[dict objectForKey:@"city"];

    }
    
    
    return label;
    
    
    


}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0) {
        index=row;
       
        if (row==0||row==1||row==2||row==3) {
            _hospitalID=[NSString stringWithFormat:@"%li",2*(row+1)];
            _page=1;
            _isReshData=YES;
             [self _loadHospitalData];
        }
        
        [pickerView reloadAllComponents];
        
    }
    if (component==1) {
        NSArray *array=[[NSArray alloc]init];
        array=_cityArray[index];
        NSDictionary *dict=array[row];
        
        _hospitalID=[dict objectForKey:@"id"];
        _page=1;
        _isReshData=YES;
         [self _loadHospitalData];
        
    }
    
   
    
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
