//
//  KROptionCollectionView.m
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/19.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import "KROptionCollectionView.h"
#import "KROptionCollectionCell.h"
#import "KRScreenBarInterface.h"
@interface KROptionCollectionView ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectIndexRow;
@end

@implementation KROptionCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder  {
    
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0,0 , CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)setupSubviews {
    [self addSubview:self.collectionView];
    [self.collectionView reloadData];
}

- (void)reloadData {
    [self.collectionView reloadData];
}

- (CGFloat)getViewHeight {
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    NSInteger hang = (count / 4 + 1);//按页面布局
    return  (hang*[KROptionCollectionCell cellHeight]) + ((hang-1)*12) + (12*2);
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (CGRectGetWidth(collectionView.frame) - (5*12)) * 0.25;
    return CGSizeMake(width, [KROptionCollectionCell cellHeight]);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(18, 12, 18, 12);
}

#pragma mark CollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if([self.dataSource respondsToSelector:@selector(optionCollectionCellCountWithView:section:)]) {
        return [self.dataSource optionCollectionCellCountWithView:self section:section];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KROptionCollectionCell *cell = [KROptionCollectionCell cellNibWithCollectionView:collectionView forIndexPath:indexPath];
    if([self.dataSource respondsToSelector:@selector(optionCollectionCellTitleWithView:indexPath:)]) {
        cell.title = [self.dataSource optionCollectionCellTitleWithView:self indexPath:indexPath];
    }
    cell.isSelect = self.selectIndexRow == indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, cell.width, cell.height);
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, cell.width, cell.height);
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, cell.width, cell.height) cornerRadius:([KROptionCollectionCell cellHeight] *0.5)];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    
    [cell.contentView.layer insertSublayer:borderLayer atIndex:0];
    [cell.layer setMask:maskLayer];
}


#pragma mark - CollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndexRow = indexPath.row;
    if([self.delegate respondsToSelector:@selector(didSelectOptionCollectionItemWithView:indexPath:)]) {
        [self.delegate didSelectOptionCollectionItemWithView:self indexPath:indexPath];
    }
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0,0 , CGRectGetWidth(self.frame), 100) collectionViewLayout:layout];
        [KROptionCollectionCell registerNibWithCollectionView:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

@end
