//
//  KROptionCollectionCell.m
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/19.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import "KROptionCollectionCell.h"
@interface KROptionCollectionCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLB;


@end
@implementation KROptionCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLB.adjustsFontSizeToFitWidth =YES;
}

+ (instancetype)cellNibWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifier] forIndexPath:indexPath];
}

+ (void)registerNibWithCollectionView:(UICollectionView *)collectionView {
    return [collectionView registerNib:[UINib nibWithNibName:[self cellIdentifier] bundle:nil] forCellWithReuseIdentifier:[self cellIdentifier]];
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([KROptionCollectionCell class]);
}

+ (CGFloat)cellHeight {
    return 33.0;
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if(isSelect) {
        self.backgroundColor = [UIColor blueColor];
        self.titleLB.textColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor grayColor];
        self.titleLB.textColor = [UIColor darkGrayColor];
    }
}

-(void)setTitle:(NSString *)title {
    _title = title;
    self.titleLB.text = title;
}

@end
