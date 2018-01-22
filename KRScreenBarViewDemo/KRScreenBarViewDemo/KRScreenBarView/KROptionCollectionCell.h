//
//  KROptionCollectionCell.h
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/19.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KROptionCollectionCell : UICollectionViewCell

+ (instancetype)cellNibWithCollectionView:(UICollectionView *)collectionView
                        forIndexPath:(NSIndexPath *)indexPath;

+ (void)registerNibWithCollectionView:(UICollectionView *)collectionView;

+ (CGFloat)cellHeight;
+ (NSString *)cellIdentifier;

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, copy) NSString *title;
@end
