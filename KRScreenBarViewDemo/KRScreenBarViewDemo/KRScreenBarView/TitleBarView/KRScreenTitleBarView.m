//
//  KRScreenTitleBarView.m
//  ShareJobStudent
//
//  Created by AlbertHuang on 2018/1/17.
//  Copyright © 2018年 GeekBean Technology Co., Ltd. All rights reserved.
//

#import "KRScreenTitleBarView.h"
#import "KRScreenTitleButton.h"
#import "UIButton+Extension.h"
#import "KRScreenBarInterface.h"
@interface KRScreenTitleBarView ()

@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation KRScreenTitleBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self= [super initWithCoder:aDecoder];
    if(self) {
        
    }
    return  self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (int i = 0; i<self.buttonArray.count; i++) {
        KRScreenTitleButton *tmpBtn = self.buttonArray[i];
        tmpBtn.frame = CGRectMake(i*(self.width/self.buttonArray.count) , 0, self.width/self.buttonArray.count,self.height);
        [tmpBtn buttonWithEdgeInsetsStyle:BRButtonEdgeInsetsStyleRight imageTitleSpace:5];
    }
    self.lineView.frame = CGRectMake(0,self.height - 1, self.width, 1);
}

#pragma mark Setup

- (void)setupTitles:(NSArray <NSString *> *)titles {
    /** 头部初始化 */
    for (int i = 0; i<titles.count; i++) {
        NSString *title = titles[i];
        KRScreenTitleButton *tmpBtn = [KRScreenTitleButton buttonWithType:UIButtonTypeCustom];
        tmpBtn.text = title;
        tmpBtn.tag = i;
        [tmpBtn setStatus:KRScreenTitleButtonStatusNormal];
        [tmpBtn addTarget:self action:@selector(tmpActions:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tmpBtn];
        [self.buttonArray addObject:tmpBtn];
    }
    [self addSubview:self.lineView];
}

#pragma mark Actios

- (void)tmpActions:(KRScreenTitleButton *)sender {
    for (KRScreenTitleButton *tmpButton in self.buttonArray) {
        if(sender ==tmpButton) {
            [self setButtonStatusWithButton:tmpButton];
        }else{
            [self setButtonStatusDownWithButton:tmpButton];
        }
    }
    if([self.operation respondsToSelector:@selector(selectTitleBarWithButton:)]) {
        [self.operation selectTitleBarWithButton:sender];
    }
}

#pragma mark Public Methods

- (void)relaodButtonWithIndex:(NSInteger)index title:(NSString *)title{
    if(self.buttonArray.count > index) {
        KRScreenTitleButton *selectDownBtn =self.buttonArray[index];
        selectDownBtn.text = title;
        selectDownBtn.selected = YES;
        selectDownBtn.status = KRScreenTitleButtonStatusSelectDown;
    }
}

- (void)allDown {
    for (KRScreenTitleButton *tmpButton in self.buttonArray) {
        [self setButtonStatusDownWithButton:tmpButton];
    }
}

#pragma mark Private Methods

- (void)setButtonStatusDownWithButton:(KRScreenTitleButton *)sender {
    if(sender.isSelected) {
        sender.status = KRScreenTitleButtonStatusSelectDown;
    } else {
        sender.status = KRScreenTitleButtonStatusNormal;
    }
}

- (void)setButtonStatusWithButton:(KRScreenTitleButton *)sender {
    if(sender.status == KRScreenTitleButtonStatusSelectUp) {
        [self setButtonStatusDownWithButton:sender];
    } else {
        sender.status = KRScreenTitleButtonStatusSelectUp;
    }
}

#pragma mark Getter

- (NSMutableArray *)buttonArray {
    if(!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (UIView *)lineView {
    if(!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

@end
