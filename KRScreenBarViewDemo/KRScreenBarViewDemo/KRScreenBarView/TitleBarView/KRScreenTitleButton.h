//
//  KRScreenTitleButton.h
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/17.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,KRScreenTitleButtonStatus) {
    KRScreenTitleButtonStatusNormal = 0,
    KRScreenTitleButtonStatusSelectUp ,
    KRScreenTitleButtonStatusSelectDown
};
@interface KRScreenTitleButton : UIButton

@property (nonatomic) IBInspectable KRScreenTitleButtonStatus status;

@property (nonatomic) IBInspectable NSString *text;

@end
