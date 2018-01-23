//
//  ViewController.m
//  KRScreenBarViewDemo
//
//  Created by AlbertHuang on 2018/1/22.
//  Copyright © 2018年 Karo. All rights reserved.
//

#import "ViewController.h"
#import "KRScreenBarView.h"
@interface ViewController ()<
KRScreenBarViewDelegate,
KRScreenBarViewDataSource>
@property (nonatomic, strong) KRScreenBarView *screenBarView;
@property (weak, nonatomic) IBOutlet KRScreenBarView *nibScreenBarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect frame = self.view.bounds;
    frame.size.height = 44;
    frame.origin.y = 64;
    _screenBarView.frame = frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    _nibScreenBarView.delegate =self;
    _nibScreenBarView.dataSource = self;
    [self.view addSubview:self.screenBarView];
    NSArray *titles = @[@"类别", @"筛选", @"排序"];
    NSString *onelist = [NSString stringWithFormat:@"%zd",KRScreenBarViewTypeOneList];
    NSString *twolist = [NSString stringWithFormat:@"%zd",KRScreenBarViewTypeTwoList];
    NSString *collectionlist = [NSString stringWithFormat:@"%zd",KRScreenBarViewTypeCollection];
    NSArray *types = @[onelist,twolist,collectionlist];
    [_nibScreenBarView setupWithTitles:titles types:types];
    [_screenBarView setupWithTitles:titles types:types];
}

#pragma mark - KRScreenBarViewDelegate

- (void)didSelectScreenBarViewCellWithIndexPath:(NSIndexPath *)indexPath tag:(NSInteger)tag {
    
}

#pragma mark - KRScreenBarViewDataSource

- (NSString *)screenBarViewCellDataSourceWithIndexPath:(NSIndexPath *)indexPath type:(KRScreenBarViewType)type {
    switch (type) {
            case KRScreenBarViewTypeOneList:
        {
            return [self listWithIndexRow:indexPath.row];
        }
            break;
            case KRScreenBarViewTypeTwoLeftList:
        {
            return [NSString stringWithFormat:@"左%@",[self listWithIndexRow:indexPath.row]];
        }
            break;
        case KRScreenBarViewTypeTwoRightList:
        {
            return [NSString stringWithFormat:@"右%@",[self listWithIndexRow:indexPath.row]];
        }
            break;
        case KRScreenBarViewTypeCollection:
        {
            return [NSString stringWithFormat:@"地标%@",[self listWithIndexRow:indexPath.row]];
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (NSInteger)screenBarViewCellCountWithSection:(NSInteger)section type:(KRScreenBarViewType)type {
    return 5;
}

- (KRScreenBarView *)screenBarView {
    if(!_screenBarView) {
        _screenBarView = [[KRScreenBarView alloc] init];
        _screenBarView.delegate = self;
        _screenBarView.dataSource = self;
    }
    return _screenBarView;
}

- (NSString *)listWithIndexRow:(NSInteger)indexRow {
    return [NSString stringWithFormat:@"%zd",indexRow];
}

@end
