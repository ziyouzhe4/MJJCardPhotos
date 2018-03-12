//
//  ViewController.m
//  PhotoAnimationScrollDemo
//
//  Created by majianjie on 18/3/12.
//  Copyright © 2016年 majianjie. All rights reserved.
//

#import "ViewController.h"
#import "MJJMainPopoutView.h"
#import "MJJConstant.h"
#import "MJJItemModel.h"
#import <Masonry.h>

@interface ViewController () <MJJMainPopoutViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) MJJMainPopoutView *popView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.popView showInSuperView:self.view];

}

- (void)clickActionBtn:(NSInteger)selectedIndex{

    NSLog(@"点击了 %ld",(long)selectedIndex);

}

- (void)clickMeasure:(NSInteger)selectedIndex{

    NSLog(@"点击了 %ld",(long)selectedIndex);

}

#pragma mark - 懒加载数据
- (MJJMainPopoutView *)popView
{
    if (_popView == nil) {
        _popView = [[MJJMainPopoutView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT * 0.57)];
        _popView.dataSource = self.dataSource;
        _popView.backgroundColor = [UIColor greenColor];
        _popView.delegate = self;
    }
    return _popView;
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 2; i ++) {
            MJJItemModel *model = [[MJJItemModel alloc] init];
            model.imageName = @"Start_measuring_button";
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}


@end
