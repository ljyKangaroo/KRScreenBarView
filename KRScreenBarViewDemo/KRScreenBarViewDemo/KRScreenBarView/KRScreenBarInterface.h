//
//  KRScreenBarInterface.h
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/17.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KRScreenBarViewInterface <NSObject>

@end

// MARK: 头部View
@protocol KRScreenTitleBarViewOperation <NSObject>

@optional
/** 选择的标题回调 */
- (void)selectTitleBarWithButton:(id)button;

@end

// MARK: 自定义View的代理与数据源

@protocol KRScreenOptionListViewDataSource <NSObject>

@optional
/** cell的title */
- (NSString *)screenOptionListCellTitleWithView:(UIView *)view
                                      indexPath:(NSIndexPath *)indexPath;
/** cell的个数 */
- (NSInteger )screenOptionListCellCountWithView:(UIView *)view
                                        section:(NSInteger )section;
@end

@protocol KRScreenOptionListViewDelegate <NSObject>

@optional
/** 点击的回调 */
- (void)didSelectScreenOptionListWithView:(UIView *)view
                                indexPath:(NSIndexPath *)indexPath;
@end

@protocol KRScreenOptionTwoListViewDataSource <NSObject>

@optional
/** LeftCell的title */
- (NSString *)screenOptionTwoLeftCellTitleWithView:(UIView *)view
                                      indexPath:(NSIndexPath *)indexPath;
/** LeftCell的个数 */
- (NSInteger )screenOptionTwoLeftCellCountWithView:(UIView *)view
                                        section:(NSInteger )section;

/** RightCell的title */
- (NSString *)screenOptionTwoRightCellTitleWithView:(UIView *)view
                                         indexPath:(NSIndexPath *)indexPath;
/** RightCell的个数 */
- (NSInteger )screenOptionTwoRightCellCountWithView:(UIView *)view
                                           section:(NSInteger )section;
@end

@protocol KRScreenOptionTwoListViewDelegate <NSObject>

@optional
/** 点击的回调 */
- (void)didSelectScreenOptionTwoLeftListWithView:(UIView *)view
                                        indexPath:(NSIndexPath *)indexPath;

- (void)didSelectScreenOptionTwoRightListWithView:(UIView *)view
                                indexPath:(NSIndexPath *)indexPath;
@end

@protocol KROptionCollectionViewDataSource <NSObject>

@optional

@required

/** Cell的title */
- (NSString *)optionCollectionCellTitleWithView:(UIView *)view
                                      indexPath:(NSIndexPath *)indexPath;
/** Cell的个数 */
- (NSInteger )optionCollectionCellCountWithView:(UIView *)view
                                        section:(NSInteger )section;

@end

@protocol KROptionCollectionViewDelegate <NSObject>

@optional
/** 点击的回调 */
- (void)didSelectOptionCollectionItemWithView:(UIView *)view
                                    indexPath:(NSIndexPath *)indexPath;

@end

