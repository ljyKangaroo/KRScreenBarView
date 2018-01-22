//
//  KRScreenTitleBarView.h
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/17.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KRScreenTitleBarViewOperation;
@interface KRScreenTitleBarView : UIView

@property (nonatomic, weak) id<KRScreenTitleBarViewOperation> operation;

- (void)setupTitles:(NSArray <NSString *> *)titles;

/** 刷新选中类型的标题按钮 */
- (void)relaodButtonWithIndex:(NSInteger)index title:(NSString *)title;
/** allDown */
- (void)allDown;
@end
