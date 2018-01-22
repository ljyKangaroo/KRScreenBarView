//
//  KRScreenBarView.h
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/17.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,KRScreenBarViewType) {
    KRScreenBarViewTypeNone = 0,
    KRScreenBarViewTypeOneList,
    KRScreenBarViewTypeTwoList,
    KRScreenBarViewTypeCollection,
    KRScreenBarViewTypeTwoLeftList,///< 获取数据用,不参与类型计算
    KRScreenBarViewTypeTwoRightList///< 获取数据用，不参与类型计算
};

@protocol KRScreenBarViewDelegate <NSObject>
@optional
/** 选择回调 */
- (void)didSelectScreenBarViewCellWithIndexPath:(NSIndexPath *)indexPath
                                           type:(KRScreenBarViewType)type;
@end

@protocol KRScreenBarViewDataSource <NSObject>
@optional
@required
/** 根据type来返回对应的数据源 */
- (NSString *)screenBarViewCellDataSourceWithIndexPath:(NSIndexPath *)indexPath
                                                  type:(KRScreenBarViewType )type;
/** 根据type来返回对应的个数 */
- (NSInteger )screenBarViewCellCountWithSection:(NSInteger )section
                                           type:(KRScreenBarViewType )type;
@end

@interface KRScreenBarView : UIView

@property (nonatomic, weak) id <KRScreenBarViewDelegate> delegate;
@property (nonatomic, weak) id <KRScreenBarViewDataSource> dataSource;
/**
 *必须添加了此View才能初始化
 */
- (void)setupWithTitles:(NSArray *)titles types:(NSArray *)types;

- (void)reloadData;

- (void)reloadTitleWithTag:(NSUInteger )tag
                  indexRow:(NSUInteger )indexRow;

@end
