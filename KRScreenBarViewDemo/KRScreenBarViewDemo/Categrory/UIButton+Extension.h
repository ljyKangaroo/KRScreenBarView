//
//  UIButton+Extension.h
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/12.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, BRButtonEdgeInsetsStyle) {
    BRButtonEdgeInsetsStyleTop,     // image在上，label在下
    BRButtonEdgeInsetsStyleLeft,    // image在左，label在右
    BRButtonEdgeInsetsStyleBottom,  // image在下，label在上
    BRButtonEdgeInsetsStyleRight    // image在右，label在左
};

@interface UIButton (Extension)


/**
 *  设置button的文字和图片的布局样式，及间距
 *
 *  @param style 文字和图片的布局样式
 *  @param space 文字和图片的间距
 */
- (void)buttonWithEdgeInsetsStyle:(BRButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end
