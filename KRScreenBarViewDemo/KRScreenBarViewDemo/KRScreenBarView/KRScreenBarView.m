//
//  KRScreenBarView.m
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/17.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import "KRScreenBarView.h"
#import "KRScreenTitleButton.h"
#import "KRScreenTitleBarView.h"
#import "KRScreenOptionListView.h"
#import "KRScreenOptionTwoListView.h"
#import "KROptionCollectionView.h"

@interface KRScreenBarView ()<
KRScreenTitleBarViewOperation,
KRScreenOptionListViewDelegate,
KRScreenOptionListViewDataSource,
KRScreenOptionTwoListViewDelegate,
KRScreenOptionTwoListViewDataSource,
KROptionCollectionViewDelegate,
KROptionCollectionViewDataSource>

@property (nonatomic, strong) KRScreenTitleBarView *titleBarView;
/** 承载用的View */
@property (nonatomic, strong) UIView *optionView;
/** 遮罩 */
@property (nonatomic, strong) UIView *shadeView;
/** 自定义View的Array */
@property (nonatomic, strong) NSMutableArray <UIView *> *optionViewArray;
/** 索引 */
@property (nonatomic, assign) NSInteger index;
@end

@implementation KRScreenBarView

-(void)dealloc {
    NSLog( @"%@ delloc",self.class);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self= [super initWithCoder:aDecoder];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return  self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleBarView.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.shadeView.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), KRScreen_Width, KRScreen_Height - CGRectGetMinY(self.frame));
    [self layoutAllOptionView];
}

- (void)layoutAllOptionView {
    for (UIView *view in self.optionViewArray) {
        CGRect frame = view.frame;
        frame.origin.x = CGRectGetMinX(self.frame);
        frame.origin.y = CGRectGetMinY(self.frame) + CGRectGetHeight(self.frame);
        frame.size.width = CGRectGetWidth(self.frame);
        view.frame = frame;
    }
}

#pragma mark Setup

- (void)setupWithTitles:(NSArray *)titles types:(NSArray *)types {
    if(!self.superview)return;
    /** 从父视图来添加View 按优先级添加*/
    [self.superview addSubview:self.shadeView];
    /** 头部 */
    [self setupTitleBarViewWithTitles:titles];
    /** 筛选表 */
    [self setupOptionViewWithTypes:types];

}

- (void)setupTitleBarViewWithTitles:(NSArray <NSString *> *)titles {
    [self.superview addSubview:self.titleBarView];
    /** 头部初始化 */
    [self.titleBarView setupTitles:titles];
}

- (void)setupOptionViewWithTypes:(NSArray *)types {
    for (int i = 0; i <types.count; i ++) {
        UIView *tempView = [self optionViewWithType:[types[i] integerValue]];
        tempView.tag = i;
        [self.superview addSubview:tempView];
        [self.optionViewArray addObject:tempView];
    }
    [self layoutOptionViewWithIndex:0];
}

- (UIView *)optionViewWithType:(KRScreenBarViewType)type {
    /** 选择对应筛选表 */
    if(type == KRScreenBarViewTypeOneList) {
        return [self optionListView];
    } else if (type == KRScreenBarViewTypeTwoList) {
        return [self optionTwoListView];
    } else if (type == KRScreenBarViewTypeCollection) {
        return [self optionCollectionView];
    } else {
        return [UIView new];
    }
}

- (void)reloadData {
    for (UIView *view in self.optionViewArray) {
        if([view isKindOfClass:[KRScreenOptionListView class]]) {
            [((KRScreenOptionListView *)view) reloadData];
        } else if([view isKindOfClass:[KRScreenOptionTwoListView class]]) {
            [((KRScreenOptionTwoListView *)view) reloadData];
        } else if([view isKindOfClass:[KROptionCollectionView class]]) {
            [((KROptionCollectionView *)view) reloadData];
        }
    }
}

#pragma mark - Public Methods
/** 自定义的方法 */
- (void)reloadTitleWithTag:(NSUInteger )tag indexRow:(NSUInteger )indexRow {
    if(self.optionViewArray.count > tag) {
        UIView *tmpView = self.optionViewArray[tag];
        KRScreenBarViewType type = KRScreenBarViewTypeNone;
        if([tmpView isKindOfClass:[KRScreenOptionListView class]]) {
            ((KRScreenOptionListView *)tmpView).selectIndexRow = indexRow;
            [((KRScreenOptionListView *)tmpView) reloadData];
            type = KRScreenBarViewTypeOneList;
        }
        
        /** 刷新标题 */
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexRow inSection:0];
        [self reloadTitleButtonWithIndexPath:indexPath tag:tmpView.tag type:KRScreenBarViewTypeOneList];
    }
}

#pragma mark - TitleBarView Operation

- (void)selectTitleBarWithButton:(KRScreenTitleButton *)button{
    /** 刷新索引 */
    self.index = button.tag;
    
    if(button.status == KRScreenTitleButtonStatusSelectUp) {
        [self layoutOptionViewWithIndex:button.tag];
        [self show];
    } else {
        [self dismiss];
    }
    [self.superview layoutIfNeeded];
}

#pragma mark - ListViewDataSource

- (NSString *)screenOptionListCellTitleWithView:(UIView *)view
                                      indexPath:(NSIndexPath *)indexPath {
    return [self setTitleWithType:KRScreenBarViewTypeOneList indexPath:indexPath tag:view.tag];
}

- (NSInteger)screenOptionListCellCountWithView:(UIView *)view
                                       section:(NSInteger)section {
    return [self setCountWithType:KRScreenBarViewTypeOneList section:section tag:view.tag];
}

#pragma mark - ListViewDelegate

-(void)didSelectScreenOptionListWithView:(UIView *)view
                               indexPath:(NSIndexPath *)indexPath {
    [self selectedDismissWithView:view indexPath:indexPath type:KRScreenBarViewTypeOneList];
}

#pragma mark - TwoListViewDataSource

- (NSString *)screenOptionTwoLeftCellTitleWithView:(UIView *)view indexPath:(NSIndexPath *)indexPath {
    return [self setTitleWithType:KRScreenBarViewTypeTwoLeftList indexPath:indexPath tag:view.tag];
}

- (NSString *)screenOptionTwoRightCellTitleWithView:(UIView *)view indexPath:(NSIndexPath *)indexPath {
    return [self setTitleWithType:KRScreenBarViewTypeTwoRightList indexPath:indexPath tag:view.tag];
}

- (NSInteger)screenOptionTwoLeftCellCountWithView:(UIView *)view section:(NSInteger)section {
    return [self setCountWithType:KRScreenBarViewTypeTwoLeftList section:section tag:view.tag];
}

-(NSInteger)screenOptionTwoRightCellCountWithView:(UIView *)view section:(NSInteger)section {
    return [self setCountWithType:KRScreenBarViewTypeTwoRightList section:section tag:view.tag];
}

#pragma mark - TwoListViewDelegate

- (void)didSelectScreenOptionTwoLeftListWithView:(UIView *)view indexPath:(NSIndexPath *)indexPath {
    [self privateDidSelectWithTag:view.tag type:KRScreenBarViewTypeTwoLeftList indexPath:indexPath];
}

- (void)didSelectScreenOptionTwoRightListWithView:(UIView *)view indexPath:(NSIndexPath *)indexPath {
    [self selectedDismissWithView:view indexPath:indexPath type:KRScreenBarViewTypeTwoRightList];
}

#pragma mark - CollectionViewDataSource

- (NSString *)optionCollectionCellTitleWithView:(UIView *)view indexPath:(NSIndexPath *)indexPath {
    return [self setTitleWithType:KRScreenBarViewTypeCollection indexPath:indexPath tag:view.tag];
}

- (NSInteger)optionCollectionCellCountWithView:(UIView *)view section:(NSInteger)section {
    return [self setCountWithType:KRScreenBarViewTypeCollection section:section tag:view.tag];
}

#pragma mark -CollectionViewDelegate

-(void)didSelectOptionCollectionItemWithView:(UIView *)view indexPath:(NSIndexPath *)indexPath {
    [self selectedDismissWithView:view indexPath:indexPath type:KRScreenBarViewTypeCollection];
}

#pragma mark - Private Methods
/** 点击cell后 */
- (void)selectedDismissWithView:(UIView *)view
                      indexPath:(NSIndexPath *)indexPath
                           type:(KRScreenBarViewType)type {
    /** 刷新索引 */
    [self layoutOptionViewWithIndex:view.tag];
    
    [self reloadTitleButtonWithIndexPath:indexPath tag:view.tag type:type];
    
    [self dismiss];
    
    [self privateDidSelectWithTag:view.tag type:type indexPath:indexPath];
}
/** 根据Type获取数据源 */
- (NSString *)setTitleWithType:(KRScreenBarViewType)type
                     indexPath:(NSIndexPath *)indexPath
                           tag:(NSInteger)tag {
    if([self.dataSource respondsToSelector:@selector(screenBarViewCellDataSourceWithIndexPath:type:tag:)]) {
        return [self.dataSource screenBarViewCellDataSourceWithIndexPath:indexPath type:type tag:tag];
    }
    return nil;
}
/** 根据Type获取个数 */
- (NSInteger)setCountWithType:(KRScreenBarViewType)type
                      section:(NSInteger)section
                          tag:(NSInteger)tag {
    if([self.dataSource respondsToSelector:@selector(screenBarViewCellCountWithSection:type:tag:)]) {
        return [self.dataSource screenBarViewCellCountWithSection:section type:type tag:tag];
    }
    return 0;
}
/** 根据Tag回调对应选择方法 */
- (void)privateDidSelectWithTag:(NSInteger)tag
                           type:(KRScreenBarViewType)type
                      indexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(didSelectScreenBarViewCellWithIndexPath:type:tag:)]) {
        [self.delegate didSelectScreenBarViewCellWithIndexPath:indexPath type:type tag:tag];
    }
}
/** 刷新标题按钮 */
- (void)reloadTitleButtonWithIndexPath:(NSIndexPath *)indexPath
                                   tag:(NSUInteger )tag
                                  type:(KRScreenBarViewType)type{
    
    NSString *title = nil;
    if([self.dataSource respondsToSelector:@selector(screenBarViewCellDataSourceWithIndexPath:type:tag:)]) {
        title = [self.dataSource screenBarViewCellDataSourceWithIndexPath:indexPath type:type tag:tag];
    }
    [self.titleBarView relaodButtonWithIndex:tag title:title];
}
/** 指定当前的筛选表 */
- (void)layoutOptionViewWithIndex:(NSInteger)index {
    // 重置上一个View的高度

    [self setOptionViewWithHeight:0];
    // 根据索引到当前View
    if(self.optionViewArray.count > index) {
        self.optionView = self.optionViewArray[index];
    }
}

- (void)setOptionViewWithHeight:(CGFloat)height {
    CGRect frame = self.optionView.frame;
    frame.size.height = height;
    self.optionView.frame = frame;
}

- (void)dismiss {
    [UIView animateWithDuration:0.28 animations:^{
        self.shadeView.alpha = 0.0;
        self.optionView.alpha = 0.0;
        [self setOptionViewWithHeight:0];
        [self.optionView layoutIfNeeded];
    }];
}

- (void)show {
    [UIView animateWithDuration:0.28 animations:^{
        self.shadeView.alpha = 1.0f;
        self.optionView.alpha = 1.0f;
        [self setOptionViewWithHeight:[self optionHeight]];
        [self.optionView layoutIfNeeded];
    }];
}

- (KRScreenOptionListView *)optionListView {
    KRScreenOptionListView *view = [[KRScreenOptionListView alloc] init];
    view.delegate = self;
    view.dataSource = self;
    return view;
}

- (KRScreenOptionTwoListView *)optionTwoListView {
    KRScreenOptionTwoListView *view = [[KRScreenOptionTwoListView alloc] init];
    view.delegate = self;
    view.dataSource = self;
    return view;
}

- (KROptionCollectionView *)optionCollectionView {
    KROptionCollectionView *view = [[KROptionCollectionView alloc] init];
    view.delegate = self;
    view.dataSource =self;
    return view;
}

/** 当前的筛选表的高度 */
- (CGFloat)optionHeight {
    if([self.optionView isKindOfClass:[KRScreenOptionListView class]]) {
        return [((KRScreenOptionListView *)self.optionView) getViewHeight];
    } else if([self.optionView isKindOfClass:[KRScreenOptionTwoListView class]]) {
        return [((KRScreenOptionTwoListView *)self.optionView) getViewHeight];
    } else if([self.optionView isKindOfClass:[KROptionCollectionView class]]) {
        return [((KROptionCollectionView *)self.optionView) getViewHeight];
    }
    return 0;
}

#pragma mark - Actions
/** 隐藏遮盖前要重置按钮 */
- (void)coverAction {
    
    [self.titleBarView allDown];
    
    [self dismiss];
}

#pragma mark - Getter And Setter

- (UIView *)titleBarView {
    if(!_titleBarView) {
        _titleBarView = [[KRScreenTitleBarView alloc] init];
        _titleBarView.backgroundColor = [UIColor whiteColor];
        _titleBarView.operation = self;
    }
    return _titleBarView;
}

- (NSMutableArray<UIView *> *)optionViewArray {
    if(!_optionViewArray) {
        _optionViewArray = [NSMutableArray array];
    }
    return _optionViewArray;
}

-(UIView *)shadeView {
    if(!_shadeView) {
        _shadeView = [[UIView alloc] init];
        _shadeView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        _shadeView.alpha = 0.0;
        [_shadeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverAction)]];
    }
    return _shadeView;
}

@end
