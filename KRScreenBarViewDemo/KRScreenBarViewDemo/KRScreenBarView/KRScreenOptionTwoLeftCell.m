//
//  KRScreenOptionTwoLeftCell.m
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/18.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import "KRScreenOptionTwoLeftCell.h"
@interface KRScreenOptionTwoLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@end
@implementation KRScreenOptionTwoLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor lightGrayColor];
}

+ (instancetype)cellNibWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    
    KRScreenOptionTwoLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    
    return cell;
}

+ (void)registerNibWithTableView:(UITableView *)tableView {
    
    [tableView registerNib:[UINib nibWithNibName:[self cellIdentifier] bundle:nil] forCellReuseIdentifier:[self cellIdentifier]];
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([KRScreenOptionTwoLeftCell class]);
}

+ (CGFloat )cellHeight {
    return 45.0f;
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if(isSelect) {
        self.titleLB.textColor = [UIColor blueColor];
    } else {
         self.titleLB.textColor = [UIColor darkGrayColor];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLB.text = title;
}

@end
