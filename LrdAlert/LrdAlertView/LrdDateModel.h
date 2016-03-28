//
//  LrdDateModel.h
//  AlertTableView
//
//  Created by 键盘上的舞者 on 3/28/16.
//  Copyright © 2016 键盘上的舞者. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LrdDateModel : NSObject

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *price;

- (instancetype)initWithTime:(NSString *)time price:(NSString *)price;

@end
