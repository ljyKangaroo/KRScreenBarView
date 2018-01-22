//
//  KRScreenOptionTwoLeftCell.h
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/18.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRScreenOptionTwoLeftCell : UITableViewCell


+ (instancetype)cellNibWithTableView:(UITableView *)tableView
                        forIndexPath:(NSIndexPath *)indexPath;

+ (void)registerNibWithTableView:(UITableView *)tableView;

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, copy) NSString *title;
@end
