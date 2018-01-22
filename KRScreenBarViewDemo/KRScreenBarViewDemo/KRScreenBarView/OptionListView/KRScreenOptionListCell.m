//
//  KRScreenOptionListCell.m
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/17
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import "KRScreenOptionListCell.h"
@interface KRScreenOptionListCell ()

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UIButton *lineBtn;

@end
@implementation KRScreenOptionListCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.lineBtn.hidden = YES;
    self.lineBtn.layer.masksToBounds =YES;
    self.lineBtn.layer.cornerRadius = self.lineBtn.height *0.5;
}

+ (instancetype)cellNibWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    
    KRScreenOptionListCell * cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    
    return cell;
}

+ (void)registerNibWithTableView:(UITableView *)tableView {
    
    [tableView registerNib:[UINib nibWithNibName:[self cellIdentifier] bundle:nil] forCellReuseIdentifier:[self cellIdentifier]];
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([KRScreenOptionListCell class]);
}

+ (CGFloat )cellHeight {
    return 45.0f;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.nameLB.text = title;
}

-(void)setStatus:(KRScreenOptionListCellStatus)status {
    _status = status;
    
    switch (status) {
        case KRScreenOptionListCellStatusNormal:
        {
            [self.nameLB setTextColor:[UIColor darkGrayColor]];
            [self.lineBtn setHidden:YES];
            
        }
            break;
        case KRScreenOptionListCellStatusSelect:
        {
            [self.nameLB setTextColor:[UIColor blueColor]];
            [self.lineBtn setHidden:NO];
        }
            break;

        default:
        {
            [self.nameLB setTextColor:[UIColor darkGrayColor]];
            [self.lineBtn setHidden:YES];
        }
            break;
    }
}

@end
