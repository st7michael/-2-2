//
//  selfViewController.m
//  健康问问
//
//  Created by Yiqiao on 15/9/7.
//  Copyright (c) 2015年  枫自飘零. All rights reserved.
//

#import "selfViewController.h"
#import "Common.h"
#import "shopViewController.h"
#import <sqlite3.h>

@interface selfViewController (){
    UITableView *_tableView;
    UIImage *_image;
    UIButton *iconSetting;
    NSMutableDictionary *_dic;
}

@end

@implementation selfViewController

#pragma -mark tabelview属性
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row == 0) {
            return 180;
        }
        if (indexPath.row == 1) {
            return 50;
    }
    return 40;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //设置一栏头像及名字
    //personal infomation
    if (indexPath.row ==0) {
        cell.backgroundColor = [UIColor greenColor];
        
        //add button to set icom
        iconSetting = [[UIButton alloc]initWithFrame:CGRectMake((KWidth-70)/2, 40, 70, 70)];
        iconSetting.layer.masksToBounds = YES;
        iconSetting.layer.cornerRadius = 35;
        [cell.contentView addSubview:iconSetting];
        
        //
        if ([selfViewController plist] == NULL) {
            _image = [UIImage imageNamed:@"defaultIcon.jpg"];
        }else{
            _image = [selfViewController plist];
        }
        [iconSetting setImage:_image forState:UIControlStateNormal];
        iconSetting.backgroundColor = [UIColor redColor];
        [iconSetting addTarget:self action:@selector(iconButton:) forControlEvents:UIControlEventTouchUpInside];
        
        //add name
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((KWidth-180)/2, 40+70+10, 180, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"stanincountry";
        label.textAlignment = UITextAlignmentCenter;
        
        [cell.contentView addSubview:label];
    }
    //other infomation
    if (indexPath.row ==1) {
        for (int i = 0; i<3; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*(KWidth/3), 0, KWidth/3, 50)];
            if (i ==0) {
                label.text = @"医生 0";
                label.textAlignment = UITextAlignmentCenter;
                label.textColor = [UIColor orangeColor];
            }
            else if (i == 1){
                label.textAlignment = UITextAlignmentCenter;
                label.textColor = [UIColor orangeColor];
                label.text = @"病友 0";
            }
            else{
                label.text = @"话题 0";
                label.textColor = [UIColor orangeColor];
                label.textAlignment = UITextAlignmentCenter;
            }
            [cell.contentView addSubview:label];
        }
    }
    
    if (indexPath.row ==2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"我的服务";
    }
    if (indexPath.row ==3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"我的药品订单";
    }
    if (indexPath.row ==4) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"钱包";
    }
    if (indexPath.row ==5) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"收藏和分享";
    }
    if (indexPath.row ==6) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"二维码";
    }
    if (indexPath.row ==7) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"扫一扫";
    }
    if (indexPath.row == 8) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"设置";
    }
    return cell;
}

#pragma -mark 头像设置
- (void)iconButton:(UIButton *)button{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"拍摄", nil];
       [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self selectPic];
    }
    if (buttonIndex == 1) {
        [self takePic];
    }
}
- (void)selectPic{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)takePic{
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"没有摄像头" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [iconSetting setImage:image forState:UIControlStateNormal];
        
        if (picker.sourceType ==UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        //
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_100.png"]];
        [UIImagePNGRepresentation(image)writeToFile: filePath    atomically:YES];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //
    [self dicPaths];

}
//
-(void)dicPaths{
    NSMutableArray *specialArr = [[NSMutableArray alloc] initWithCapacity:0];
    _dic = [[NSMutableDictionary alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_100.png"]];
    [_dic setObject:filePath forKey:@"img"];
    [specialArr addObject:_dic];
}

+ (UIImage*)plist{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_100.png"]];   // 保存文件的名称
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    return img;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"保存完毕");
}

#pragma -mark 购物车链接
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        shopViewController *shopVC = [[shopViewController alloc]init];
        [self.navigationController pushViewController:shopVC animated:NO];
        shopVC.title = @"我的购物车";
    }
}

#pragma -mark BASE
- (void)_createViews{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWidth, 510+64)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    
//    UIButton *backButton =[[UIButton alloc]initWithFrame:CGRectMake(20, 35, 40, 40)];
//    [_tableView addSubview:backButton];
//    backButton.backgroundColor = [UIColor clearColor];
//    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [backButton setTitle:@"返回" forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(backAct:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBarHidden = NO;
    self.title = @"个人中心";
    [self _createViews];
    
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
