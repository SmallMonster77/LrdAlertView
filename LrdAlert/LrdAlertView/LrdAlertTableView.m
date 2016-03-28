//
//  LrdAlertTableView.m
//  AlertTableView
//
//  Created by 键盘上的舞者 on 3/28/16.
//  Copyright © 2016 键盘上的舞者. All rights reserved.
//

#import "LrdAlertTableView.h"
#import "Masonry.h"
#import "LrdTableViewCell.h"
#import "LrdDateModel.h"

#define tableViewHeight [UIScreen mainScreen].bounds.size.height - 80 -100

@interface LrdAlertTableView () <UITableViewDataSource, UITableViewDelegate>
//背景
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIView *contentView;
//标题
@property (nonatomic, strong) UILabel *title;
//子标题
@property (nonatomic, strong) UILabel *subTitle;
//线条
@property (nonatomic, strong) UILabel *line;
//tableView
@property (nonatomic, strong) UITableView *tableView;
//关闭按钮
@property (nonatomic, strong) UIButton *closeButton;


@end

@implementation LrdAlertTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //初始化各种控件
        _backgroundView = [[UIView alloc] initWithFrame:frame];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:_backgroundView];
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 5;
        [self addSubview:_contentView];
        
        _title = [[UILabel alloc] init];
        _title.font = [UIFont boldSystemFontOfSize:18];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor blackColor];
        _title.text = @"还款详情";
        [self.contentView addSubview:_title];
        
        _subTitle = [[UILabel alloc] init];
        _subTitle.font = [UIFont systemFontOfSize:13];
        _subTitle.textColor = [UIColor grayColor];
        _subTitle.textAlignment = NSTextAlignmentCenter;
        _subTitle.text = @"每月应还本金￥50.00";
        [self.contentView addSubview:_subTitle];
        
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_line];
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_closeButton];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:_tableView];
        
        //添加布局约束
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(100);
        make.left.equalTo(self.mas_left).offset(50);
        make.right.equalTo(self.mas_right).offset(-50);
        make.height.mas_equalTo(tableViewHeight);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(25);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(20);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTitle.mas_bottom).offset(20);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@1);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
}

#pragma mark pop和dismiss

- (void)pop {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    
    //动画效果入场
    self.contentView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.contentView.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.contentView.alpha = 1;
    }];
}

- (void)dismiss {
    //动画效果出场
    [UIView animateWithDuration:.35 animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.contentView]) {
        [self dismiss];
    }
}

#pragma mark tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    LrdTableViewCell *cell = (LrdTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LrdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.dataArray[indexPath.row];
    cell.userInteractionEnabled = NO;
    return cell;
}

@end
