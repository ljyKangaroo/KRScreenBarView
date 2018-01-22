//
//  KROptionCollectionView.h
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/19.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRScreenBarInterface.h"
@interface KROptionCollectionView : UIView
@property (nonatomic, weak) id <KROptionCollectionViewDataSource> dataSource;
@property (nonatomic, weak) id <KROptionCollectionViewDelegate> delegate;

- (void)reloadData;

- (CGFloat)getViewHeight;

@end
