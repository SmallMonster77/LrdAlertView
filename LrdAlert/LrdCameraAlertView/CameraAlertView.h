//
//  CameraAlertView.h
//  CameraAlertView
//
//  Created by 键盘上的舞者 on 3/28/16.
//  Copyright © 2016 键盘上的舞者. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LrdAlertButtonType) {
    LrdAlertButtonTypeCamera = 0,
    LrdAlertButtonTypeAlbum,
    LrdAlertButtonTypeCancel
};

//代理
@protocol LrdCameraAlertDelegate <NSObject>

@optional
- (void)buttonClickedWithType:(LrdAlertButtonType)type;

@end

@interface CameraAlertView : UIView

@property (nonatomic, weak) id<LrdCameraAlertDelegate> delegate;

//弹出
- (void)pop;
//消失
- (void)dismiss;

@end
