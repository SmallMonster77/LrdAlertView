//
//  LrdDateModel.m
//  AlertTableView
//
//  Created by 键盘上的舞者 on 3/28/16.
//  Copyright © 2016 键盘上的舞者. All rights reserved.
//

#import "LrdDateModel.h"

@implementation LrdDateModel

- (instancetype)initWithTime:(NSString *)time price:(NSString *)price {
    LrdDateModel *model = [[LrdDateModel alloc] init];
    model.time = time;
    model.price = price;
    return model;
}

@end
