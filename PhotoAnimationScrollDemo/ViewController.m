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
#import "UIColor+Extension.h"


@interface ViewController () <MJJMainPopoutViewDelegate>

// 血压连接
@property (nonatomic,strong)UIImageView *circleImg;
@property (nonatomic,strong)UIImageView *staticIcon;
@property (nonatomic,strong)UILabel *contectLabel;
@property (nonatomic,strong)UIView *bottomView;

@property (nonatomic,strong)UIView *measureView;
@property (nonatomic,strong)UIButton *measureBtn;
@property (nonatomic,strong)UILabel *batteryLabel;


// 轮播图
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) MJJMainPopoutView *popView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1. 连接血压过程的动画
    [self connectXyanimation];

    // 2.  以下 是 左右滚动 视图
//    [self scrollAnimation];
}

// ======================== 连接血压过程的动画 ========================= //
- (void)connectXyanimation{

    self.title = @"血压测量";

    // 动画步骤
    // 1. 外面圆转圈
    CGFloat width = self.view.frame.size.width * 0.6;
    self.circleImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.2, 114, width, width)];
    self.circleImg.image = [UIImage imageNamed:@"wait"];
    self.staticIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"血压计"]];
    self.staticIcon.center = self.circleImg.center;

    self.contectLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.circleImg.frame) + 16, self.view.frame.size.width - 40, 30)];
    self.contectLabel.text = @"正在连接血压计";
    self.contectLabel.textAlignment = NSTextAlignmentCenter;
    self.contectLabel.textColor = [UIColor lightGrayColor];

    [self.view addSubview:self.circleImg];
    [self.view addSubview:self.staticIcon];
    [self.view addSubview:self.contectLabel];

    [self firstAnimation];
    // 2. 上面结束后下面的view升起来 按钮变大  上面图出现
    // 2.1 添加最下面的view

    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 250)];
    self.bottomView.backgroundColor = [UIColor colorWithHexString:@"36abf5"];
    [self.view addSubview:self.bottomView];

    self.measureView = [[UIView alloc] initWithFrame:CGRectMake(self.bottomView.frame.size.width * 0.4 , 35, self.bottomView.frame.size.width / 5, self.bottomView.frame.size.width / 5)];
    self.measureView.layer.cornerRadius = self.measureView.frame.size.width / 2;
    self.measureView.backgroundColor = [UIColor whiteColor];
    self.measureView.layer.masksToBounds = YES;
    [self.bottomView addSubview:self.measureView];
    self.measureBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.measureView.frame.size.height / 2 - 20, self.measureView.frame.size.width - 20, 40)];
    [self.measureBtn setTitle:@"开始测量" forState:UIControlStateNormal];
    self.measureBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.measureBtn setTitleColor:[UIColor colorWithHexString:@"36abf5"] forState:UIControlStateNormal];
    [self.measureView addSubview:self.measureBtn];


    self.batteryLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, self.bottomView.frame.size.height - 60, self.bottomView.frame.size.width, 18)];
    self.batteryLabel.text = @"血压计剩余电量 40%";
    self.batteryLabel.textColor = [UIColor whiteColor];
    self.batteryLabel.textAlignment = NSTextAlignmentCenter;
    self.batteryLabel.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:self.batteryLabel];

    [self performSelector:@selector(secondAnimation) withObject:nil afterDelay:3];

}

- (void)secondAnimation{

    [self.circleImg removeFromSuperview];
    [self.staticIcon removeFromSuperview];
    [self.contectLabel removeFromSuperview];

    [self performSelector:@selector(thirdAnimation) withObject:nil afterDelay:0.5];

    [UIView animateWithDuration:1 animations:^{

        self.bottomView.frame = CGRectMake(0, self.view.frame.size.height - 250, self.view.frame.size.width, 250);
    } completion:^(BOOL finished) {

    }];


}

- (void)thirdAnimation{

    [UIView beginAnimations:@"transform.scale" context:nil];

    [UIView setAnimationDuration:0.4];
    [UIView setAnimationRepeatCount:1];

    self.measureView.frame = CGRectMake(self.bottomView.frame.size.width / 3 , 35, self.bottomView.frame.size.width / 3, self.bottomView.frame.size.width / 3);
    self.measureBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    self.measureBtn.frame = CGRectMake(10, self.measureView.frame.size.height / 2 - 20, self.measureView.frame.size.width - 20, 40);
    self.measureView.layer.cornerRadius = self.measureView.frame.size.width / 2;

    [UIView commitAnimations];

//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    anim.fromValue = [NSNumber numberWithFloat:1.f];
//    anim.toValue = [NSNumber numberWithFloat:1.4f];
//    anim.duration = 0.5;
//    anim.removedOnCompletion = YES;
//    anim.repeatCount = 1;
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [self.measureView.layer addAnimation:anim forKey:nil];

}


- (void)firstAnimation{

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue = [NSNumber numberWithFloat: -M_PI * 2];
        animation.duration = 1.5;
        animation.autoreverses = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = 2;//MAXFLOAT;
   [self.circleImg.layer addAnimation:animation forKey:nil];

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
