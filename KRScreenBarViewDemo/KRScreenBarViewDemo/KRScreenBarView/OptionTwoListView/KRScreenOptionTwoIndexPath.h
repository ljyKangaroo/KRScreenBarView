//
//  KRScreenOptionTwoIndexPath.h
//  KRScreenBarViewDemo
//
//  Created by AlbertHuang on 2018/1/22.
//  Copyright © 2018年 Karo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KRScreenOptionTwoIndexPath : NSObject

@property (nonatomic, assign) NSInteger firstRow;
@property (nonatomic, assign) NSInteger secondRow;
@property (nonatomic, strong) NSString *secondCate;

- (instancetype)initWithFirstRow:(NSInteger)firstRow
                       secondRow:(NSInteger)secondRow
                      secondCate:(NSString *)secondCate;

+ (KRScreenOptionTwoIndexPath *)defaultIndexPath;

@end
