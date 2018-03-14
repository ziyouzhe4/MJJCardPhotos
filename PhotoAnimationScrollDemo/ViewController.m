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
#import "MeasureBloodView.h"
#import "MeasureBloodFaild.h"


@interface ViewController () <MJJMainPopoutViewDelegate>

// 血压连接

@property (nonatomic,strong)MeasureBloodView *measureBloodView;
@property (nonatomic,strong)MeasureBloodFaild *measureFaildView;

// 轮播图
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) MJJMainPopoutView *popView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"血压测量";

    // 1. 连接血压过程的动画
    [self configMeasureView];

    // 2.  以下 是 左右滚动 视图
//    [self scrollAnimation];
}

// ----------------------以下是 测量血压相关方法 -------------------------- //

- (void)configMeasureView{

    __weak typeof(self) WeakSelf = self;

    self.measureFaildView = [MeasureBloodFaild loadFaildView];
    self.measureFaildView.frame = self.view.bounds;
    self.measureFaildView.reconnectMeasure = ^{

        [WeakSelf createMeasureView];

    };
    [self.view addSubview:self.measureFaildView];

    [self createMeasureView];

}

- (void)createMeasureView{

    __weak typeof(self) WeakSelf = self;

    self.measureBloodView = [[MeasureBloodView alloc] initWithFrame:self.view.bounds];
    self.measureBloodView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.measureBloodView];

    [self.measureBloodView setStartMeasure:^{

        [WeakSelf faild];

    }];

    [self.measureBloodView connectXyanimation];


}

- (void)faild{

    [self.measureBloodView removeFromSuperview];
    [self.view bringSubviewToFront:self.measureFaildView];

}


// ------------------------ 以下 是 左右滚动 视图------------------------ //

- (void)scrollAnimation{
    self.popView.showRemindBtn = YES;
    [self.popView showInSuperView:self.view];
}
- (void)clickActionBtn:(NSInteger)selectedIndex{NSLog(@"点击了 %ld",(long)selectedIndex);}
- (void)clickMeasure:(NSInteger)selectedIndex{NSLog(@"点击了 %ld",(long)selectedIndex);}
#pragma mark - 懒加载数据
- (MJJMainPopoutView *)popView
{
    if (_popView == nil) {
        _popView = [[MJJMainPopoutView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.63)];
        _popView.dataSource = self.dataSource;
        _popView.backgroundColor = [UIColor redColor];
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
