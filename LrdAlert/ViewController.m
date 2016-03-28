//
//  ViewController.m
//  LrdAlert
//
//  Created by 键盘上的舞者 on 3/28/16.
//  Copyright © 2016 键盘上的舞者. All rights reserved.
//

#import "ViewController.h"
#import "LrdAlertTableView.h"
#import "CameraAlertView.h"
#import "LrdPasswordAlertView.h"
#import "LrdDateModel.h"

@interface ViewController () <LrdCameraAlertDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) CameraAlertView *alertView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        //添加几个假数据
        for (int i=0; i<20; i++) {
            NSString *time = [NSString stringWithFormat:@"2016年2月%d日", i];
            NSString *price = [NSString stringWithFormat:@"5%d", i];
            LrdDateModel *temp = [[LrdDateModel alloc] initWithTime:time price:price];
            [self.dataArray addObject:temp];
        }
    }
    return _dataArray;
}

- (IBAction)PasswordAlert:(id)sender {
    LrdPasswordAlertView *testView = [[LrdPasswordAlertView alloc] initWithFrame:self.view.bounds];
    testView.block = ^(NSString *text){
        NSLog(@"调用了block");
    };
    [testView pop];
}
- (IBAction)tableAlertView:(id)sender {
    LrdAlertTableView *view = [[LrdAlertTableView alloc] initWithFrame:self.view.bounds];
    //传入数据
    view.dataArray = self.dataArray;
    
    [view pop];
}
- (IBAction)cameraAlert:(id)sender {
    self.alertView = nil;
    self.alertView = [[CameraAlertView alloc] initWithFrame:self.view.bounds];
    self.alertView.delegate = self;
    [self.alertView pop];
}

- (void)buttonClickedWithType:(LrdAlertButtonType)type {
    self.picker = nil;
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    if (type == LrdAlertButtonTypeCamera) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.alertView dismiss];
        [self presentViewController:self.picker animated:YES completion:nil];
    }else if (type == LrdAlertButtonTypeAlbum) {
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.alertView dismiss];
        [self presentViewController:self.picker animated:YES completion:nil];
    }else {
        [self.alertView dismiss];
    }
}

#pragma mark picker的代理方法实现

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self.picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    self.imgView.image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.picker dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
