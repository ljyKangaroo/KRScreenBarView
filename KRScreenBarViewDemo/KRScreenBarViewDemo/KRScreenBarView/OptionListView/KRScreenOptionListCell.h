//
//  KRScreenOptionListCell.h
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/17.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KRScreenOptionListCellStatus) {
    KRScreenOptionListCellStatusNone = 0,
    KRScreenOptionListCellStatusNormal ,
    KRScreenOptionListCellStatusSelect
};
@interface KRScreenOptionListCell : UITableViewCell

+ (instancetype)cellNibWithTableView:(UITableView *)tableView
                        forIndexPath:(NSIndexPath *)indexPath;

+ (void)registerNibWithTableView:(UITableView *)tableView;

@property (nonatomic, assign) KRScreenOptionListCellStatus status;

@property (nonatomic, copy) NSString *title;

@end
