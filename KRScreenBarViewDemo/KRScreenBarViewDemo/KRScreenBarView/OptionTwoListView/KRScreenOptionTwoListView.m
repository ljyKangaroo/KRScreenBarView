//
//  KRScreenOptionTwoListView.m
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/18.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import "KRScreenOptionTwoListView.h"
#import "KRScreenOptionTwoLeftCell.h"
#import "KRScreenOptionTwoRightCell.h"
#import "KRScreenOptionTwoIndexPath.h"
#import "KRScreenBarInterface.h"
@interface KRScreenOptionTwoListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *rightTableView;

@property (strong, nonatomic) KRScreenOptionTwoIndexPath *selectedIndexPath;
@end

@implementation KRScreenOptionTwoListView

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
    self.leftTableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame) *0.3, CGRectGetHeight(self.frame));
    self.rightTableView.frame = CGRectMake(CGRectGetWidth(self.frame) *0.3, 0, CGRectGetWidth(self.frame)*0.7, CGRectGetHeight(self.frame));
}

- (void)setupSubviews {
    [self addSubview:self.leftTableView];
    [self addSubview:self.rightTableView];
}

- (void)reloadData {
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

- (CGFloat)getViewHeight {
    return ([self.leftTableView numberOfRowsInSection:0] *[KRScreenOptionTwoLeftCell cellHeight]);
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.leftTableView) {
        if([self.dataSource respondsToSelector:@selector(screenOptionTwoLeftCellCountWithView:section:)]) {
            return [self.dataSource screenOptionTwoLeftCellCountWithView:self section:section];
        }
    } else if(tableView == self.rightTableView) {
        if([self.dataSource respondsToSelector:@selector(screenOptionTwoRightCellCountWithView:section:)]) {
            return [self.dataSource screenOptionTwoRightCellCountWithView:self section:section];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == self.leftTableView) {
            KRScreenOptionTwoLeftCell *cell = [KRScreenOptionTwoLeftCell cellNibWithTableView:tableView forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.isSelect = self.selectedIndexPath.firstRow == indexPath.row;
            if([self.dataSource respondsToSelector:@selector(screenOptionTwoLeftCellTitleWithView:indexPath:)]) {
                cell.title = [self.dataSource screenOptionTwoLeftCellTitleWithView:self indexPath:indexPath];
            }
            return cell;
    } else if(tableView == self.rightTableView){
        KRScreenOptionTwoRightCell *cell = [KRScreenOptionTwoRightCell cellNibWithTableView:tableView forIndexPath:indexPath];
        NSString *title = nil;
        if([self.dataSource respondsToSelector:@selector(screenOptionTwoRightCellTitleWithView:indexPath:)]) {
            title = [self.dataSource screenOptionTwoRightCellTitleWithView:self indexPath:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isSelect = (self.selectedIndexPath.secondRow == indexPath.row) && ([title isEqualToString: self.selectedIndexPath.secondCate]);
        cell.title = title;
        return cell;
    }
    return [UITableViewCell new];

}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if( tableView == self.leftTableView) {
        return [KRScreenOptionTwoLeftCell cellHeight];
    } else if(tableView == self.rightTableView) {
        return [KRScreenOptionTwoRightCell cellHeight];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == self.leftTableView) {
        self.selectedIndexPath.firstRow = indexPath.row;
        if([self.delegate respondsToSelector:@selector(didSelectScreenOptionTwoLeftListWithView:indexPath:)]) {
            [self.delegate didSelectScreenOptionTwoLeftListWithView:self indexPath:indexPath];
        }
        [self reloadData];
        
    } else if(tableView == self.rightTableView){
        self.selectedIndexPath.secondRow = indexPath.row;
        
        
        if([self.dataSource respondsToSelector:@selector(screenOptionTwoLeftCellTitleWithView:indexPath:)]) {
            self.selectedIndexPath.secondCate = [self.dataSource screenOptionTwoRightCellTitleWithView:self indexPath:indexPath];
        }
        
        if([self.delegate respondsToSelector:@selector(didSelectScreenOptionTwoRightListWithView:indexPath:)]) {
            [self.delegate didSelectScreenOptionTwoRightListWithView:self indexPath:indexPath];
        }
        [self.rightTableView reloadData];
    }

}

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [UITableView new];
        [KRScreenOptionTwoLeftCell registerNibWithTableView:_leftTableView];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.estimatedRowHeight = 0;
        _leftTableView.estimatedSectionHeaderHeight = 0;
        _leftTableView.estimatedSectionFooterHeight = 0;
        _leftTableView.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _leftTableView;
}

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [UITableView new];
        [KRScreenOptionTwoRightCell registerNibWithTableView:_rightTableView];
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableView.estimatedRowHeight = 0;
        _rightTableView.estimatedSectionHeaderHeight = 0;
        _rightTableView.estimatedSectionFooterHeight = 0;
        _rightTableView.backgroundColor = [UIColor whiteColor];
        
    }
    return _rightTableView;
}

- (KRScreenOptionTwoIndexPath *)selectedIndexPath {
    if (!_selectedIndexPath) {
        _selectedIndexPath = [KRScreenOptionTwoIndexPath defaultIndexPath];
    }
    return _selectedIndexPath;
}


@end
