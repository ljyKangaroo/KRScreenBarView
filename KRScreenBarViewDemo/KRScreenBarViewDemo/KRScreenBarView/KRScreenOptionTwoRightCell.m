//
//  KRScreenOptionTwoRightCell.m
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/18.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import "KRScreenOptionTwoRightCell.h"
@interface KRScreenOptionTwoRightCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIButton *lineBtn;

@end
@implementation KRScreenOptionTwoRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineBtn.hidden = YES;
    self.lineBtn.layer.masksToBounds =YES;
    self.lineBtn.layer.cornerRadius = self.lineBtn.frame.size.height *0.5;
}

+ (instancetype)cellNibWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    
    KRScreenOptionTwoRightCell * cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    
    return cell;
}

+ (void)registerNibWithTableView:(UITableView *)tableView {
    
    [tableView registerNib:[UINib nibWithNibName:[self cellIdentifier] bundle:nil] forCellReuseIdentifier:[self cellIdentifier]];
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([KRScreenOptionTwoRightCell class]);
}

+ (CGFloat )cellHeight {
    return 45.0f;
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if(isSelect) {
        self.lineBtn.hidden = NO;
        self.titleLB.textColor = [UIColor blueColor];
    } else {
        self.lineBtn.hidden = YES;
        self.titleLB.textColor = [UIColor darkGrayColor];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLB.text = title;
}

@end
