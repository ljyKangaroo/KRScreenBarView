//
//  KRScreenTitleButton.m
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/17.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import "KRScreenTitleButton.h"
#import "UIButton+Extension.h"
@implementation KRScreenTitleButton


- (void)setStatus:(KRScreenTitleButtonStatus)status {
    _status = status;
    switch (status) {
        case KRScreenTitleButtonStatusNormal:
        {
            [self setButtonImageWithName:@"btn_home_an"];
            [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
           
        }
            break;
        case KRScreenTitleButtonStatusSelectUp:
        {
            [self setButtonImageWithName:@"btn_home_pack_up"];
            [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
            break;
        case KRScreenTitleButtonStatusSelectDown:
        {
            [self setButtonImageWithName:@"btn_home_an_blue"];
            [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            self.selected = YES;
        }
            break;
        default:
        {
            [self setButtonImageWithName:@"btn_home_an"];
            [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
            break;
    }
    
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self buttonWithEdgeInsetsStyle:BRButtonEdgeInsetsStyleRight imageTitleSpace:5];
}

- (void)setText:(NSString *)text {
    [self setTitle:text forState:UIControlStateNormal];
    [self buttonWithEdgeInsetsStyle:BRButtonEdgeInsetsStyleRight imageTitleSpace:5];
}


- (void)setButtonImageWithName:(NSString *)name {
    [self setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
}

@end
