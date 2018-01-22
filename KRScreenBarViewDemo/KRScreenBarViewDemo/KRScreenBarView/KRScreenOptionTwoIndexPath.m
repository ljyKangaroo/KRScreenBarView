//
//  KRScreenOptionTwoIndexPath.m
//  KRScreenBarViewDemo
//
//  Created by AlbertHuang on 2018/1/22.
//  Copyright © 2018年 Karo. All rights reserved.
//

#import "KRScreenOptionTwoIndexPath.h"

@implementation KRScreenOptionTwoIndexPath

- (instancetype)initWithFirstRow:(NSInteger)firstRow
                       secondRow:(NSInteger)secondRow
                      secondCate:(NSString *)secondCate {
    self = [super init];
    if (self) {
        self.firstRow = firstRow;
        self.secondRow = secondRow;
        self.secondCate = secondCate;
    }
    return self;
}

+ (KRScreenOptionTwoIndexPath *)defaultIndexPath {
    KRScreenOptionTwoIndexPath *indexPath = [[KRScreenOptionTwoIndexPath alloc] initWithFirstRow:0 secondRow:-1 secondCate:nil];
    return indexPath;
}


@end
