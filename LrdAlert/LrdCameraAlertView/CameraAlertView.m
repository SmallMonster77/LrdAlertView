//
//  CameraAlertView.m
//  CameraAlertView
//
//  Created by 键盘上的舞者 on 3/28/16.
//  Copyright © 2016 键盘上的舞者. All rights reserved.
//

#import "CameraAlertView.h"
#import "Masonry.h"

@interface CameraAlertView ()

//背景
@property (nonatomic, strong) UIView *backgroundView;
//容器
@property (nonatomic, strong) UIView *contentView;
//三个按钮
@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIButton *albumButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation CameraAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //初始化各种子控件
        _backgroundView = [[UIView alloc] initWithFrame:frame];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:_backgroundView];
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setTitle:@"相机" forState:UIControlStateNormal];
        [_cameraButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cameraButton setBackgroundColor:[UIColor orangeColor]];
        _cameraButton.layer.cornerRadius = 5;
        _cameraButton.tag = LrdAlertButtonTypeCamera;
        [_cameraButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_cameraButton];
        
        _albumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_albumButton setTitle:@"从相册选择" forState:UIControlStateNormal];
        [_albumButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_albumButton setBackgroundColor:[UIColor whiteColor]];
        _albumButton.layer.borderWidth = 1;
        _albumButton.layer.borderColor = [UIColor grayColor].CGColor;
        _albumButton.layer.cornerRadius = 5;
        _albumButton.tag = LrdAlertButtonTypeAlbum;
        [_albumButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_albumButton];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton setBackgroundColor:[UIColor grayColor]];
        _cancelButton.layer.cornerRadius = 5;
        _cancelButton.tag = LrdAlertButtonTypeCancel;
        [_cancelButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_cancelButton];
        
        //添加布局
        [self initUI];
    }
    return self;
}

#pragma mark 初始化UI
- (void)initUI {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@200);
    }];
    
    [self.cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(30);
        make.left.equalTo(self.contentView.mas_left).offset(40);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
    }];
    
    [self.albumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cameraButton.mas_bottom).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(40);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.albumButton.mas_bottom).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(40);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
    }];
    
}

#pragma mark 方法实现

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.contentView]) {
        [self dismiss];
    }
}

- (void)buttonClicked:(UIButton *)button {
    if ([_delegate respondsToSelector:@selector(buttonClickedWithType:)]) {
        [_delegate buttonClickedWithType:button.tag];
    }
}

- (void)pop {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    [UIView animateWithDuration:.35 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -200);
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:.35 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end
