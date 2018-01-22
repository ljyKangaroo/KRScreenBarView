//
//  KRScreenOptionListView.h
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/17.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRScreenBarInterface.h"
@interface KRScreenOptionListView :UIView

@property (nonatomic, weak) id <KRScreenOptionListViewDataSource> dataSource;

@property (nonatomic, weak) id <KRScreenOptionListViewDelegate> delegate;

@property (nonatomic, assign) NSInteger selectIndexRow;

- (void)reloadData;

- (CGFloat )getViewHeight;
@end
