//
//  KRScreenOptionTwoListView.h
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/18.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRScreenBarInterface.h"
@interface KRScreenOptionTwoListView : UIView

@property (nonatomic, weak) id <KRScreenOptionTwoListViewDataSource> dataSource;
@property (nonatomic, weak) id <KRScreenOptionTwoListViewDelegate> delegate;

//@property (nonatomic, assign) NSInteger selectIndexRow;

- (void)reloadData;

- (CGFloat)getViewHeight;

@end
