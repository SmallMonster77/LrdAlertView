//
//  LrdTableViewCell.m
//  AlertTableView
//
//  Created by 键盘上的舞者 on 3/28/16.
//  Copyright © 2016 键盘上的舞者. All rights reserved.
//

#import "LrdTableViewCell.h"
#import "LrdDateModel.h"
#import "Masonry.h"

@interface LrdTableViewCell ()

@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *price;

@end

@implementation LrdTableViewCell

#pragma mark 重写model的set方法

- (void)setModel:(LrdDateModel *)model {
    _model = model;
    self.time.text = model.time;
    self.price.text = [NSString stringWithFormat:@"￥ %@", self.model.price];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _time = [[UILabel alloc] init];
        _time.textColor = [UIColor grayColor];
        _time.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_time];
        
        _price = [[UILabel alloc] init];
        _price.textColor = [UIColor blackColor];
        _price.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:_price];
        
        //设置约束
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(30);
            make.top.equalTo(self.contentView.mas_top).offset(10);
        }];
        
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-40);
            make.top.equalTo(self.contentView.mas_top).offset(10);
        }];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
