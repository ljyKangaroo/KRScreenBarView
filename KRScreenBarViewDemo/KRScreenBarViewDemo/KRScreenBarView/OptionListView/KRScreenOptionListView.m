//
//  KRScreenOptionListView.m
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/17.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import "KRScreenOptionListView.h"
#import "KRScreenOptionListCell.h"
#import "KRScreenBarInterface.h"
@interface KRScreenOptionListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;


@end
@implementation KRScreenOptionListView

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
    self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)setupSubviews {
    [self addSubview:self.tableView];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (CGFloat )getViewHeight {
    return ([self.tableView numberOfRowsInSection:0] * [KRScreenOptionListCell cellHeight]);
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.dataSource respondsToSelector:@selector(screenOptionListCellCountWithView:section:)]) {
        return [self.dataSource screenOptionListCellCountWithView:self section:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KRScreenOptionListCell *cell = [KRScreenOptionListCell cellNibWithTableView:tableView forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.status = self.selectIndexRow == indexPath.row ? KRScreenOptionListCellStatusSelect : KRScreenOptionListCellStatusNormal;
    if([self.dataSource respondsToSelector:@selector(screenOptionListCellTitleWithView:indexPath:)]) {
        cell.title = [self.dataSource screenOptionListCellTitleWithView:self indexPath:indexPath];
    }
    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [KRScreenOptionListCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndexRow = indexPath.row;
    [self.tableView reloadData];
    if([self.delegate respondsToSelector:@selector(didSelectScreenOptionListWithView:indexPath:)]) {
        [self.delegate didSelectScreenOptionListWithView:self indexPath:indexPath];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        [KRScreenOptionListCell registerNibWithTableView:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = [UIColor whiteColor];
        
    }
    return _tableView;
}

@end
