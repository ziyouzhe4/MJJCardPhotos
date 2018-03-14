//
//  MeasureBloodView.m
//  PhotoAnimationScrollDemo
//
//  Created by majianjie on 2018/3/14.
//  Copyright © 2018年 MKJING. All rights reserved.
//

#import "MeasureBloodView.h"
#import "UIColor+Extension.h"

@interface MeasureBloodView()

// 血压连接
@property (nonatomic,strong)UIImageView *circleImg;
@property (nonatomic,strong)UIImageView *staticIcon;
@property (nonatomic,strong)UILabel *contectLabel;
@property (nonatomic,strong)UIView *bottomView;

@property (nonatomic,strong)UIView *measureView;
@property (nonatomic,strong)UIButton *measureBtn;
@property (nonatomic,strong)UILabel *batteryLabel;

@property (nonatomic,strong)UIImageView *armImg;



@end

@implementation MeasureBloodView

// ======================== 连接血压过程的动画 ========================= //
- (void)connectXyanimation{

    // 动画步骤
    // 1. 外面圆转圈
    CGFloat width = self.frame.size.width * 0.6;
    self.circleImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.2, 114, width, width)];
    self.circleImg.image = [UIImage imageNamed:@"wait"];
    self.staticIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"血压计"]];
    self.staticIcon.center = self.circleImg.center;

    self.contectLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.circleImg.frame) + 16, self.frame.size.width - 40, 30)];
    self.contectLabel.text = @"正在连接血压计";
    self.contectLabel.textAlignment = NSTextAlignmentCenter;
    self.contectLabel.textColor = [UIColor lightGrayColor];

    [self addSubview:self.circleImg];
    [self addSubview:self.staticIcon];
    [self addSubview:self.contectLabel];

    [self firstAnimation];
    // 2. 上面结束后下面的view升起来 按钮变大  上面图出现
    // 2.1 添加最下面的view

    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 250)];
    self.bottomView.backgroundColor = [UIColor colorWithHexString:@"36abf5"];
    [self addSubview:self.bottomView];

    self.measureView = [[UIView alloc] initWithFrame:CGRectMake(self.bottomView.frame.size.width * 0.4 , 35, self.bottomView.frame.size.width / 5, self.bottomView.frame.size.width / 5)];
    self.measureView.layer.cornerRadius = self.measureView.frame.size.width / 2;
    self.measureView.backgroundColor = [UIColor whiteColor];
    self.measureView.layer.masksToBounds = YES;
    [self.bottomView addSubview:self.measureView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMeasure)];
    [self.measureView addGestureRecognizer:tap];
    self.measureBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.measureView.frame.size.height / 2 - 20, self.measureView.frame.size.width - 20, 40)];
    [self.measureBtn setTitle:@"开始测量" forState:UIControlStateNormal];
    [self.measureBtn addTarget:self action:@selector(tapMeasure) forControlEvents:UIControlEventTouchUpInside];
    self.measureBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.measureBtn setTitleColor:[UIColor colorWithHexString:@"36abf5"] forState:UIControlStateNormal];
    [self.measureView addSubview:self.measureBtn];


    self.batteryLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, self.bottomView.frame.size.height - 60, self.bottomView.frame.size.width, 18)];
    self.batteryLabel.text = @"血压计剩余电量 40%";
    self.batteryLabel.textColor = [UIColor whiteColor];
    self.batteryLabel.textAlignment = NSTextAlignmentCenter;
    self.batteryLabel.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:self.batteryLabel];


    // 添加手臂的图片
    ;
    self.armImg = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 360 ) / 2, 110, 360, 250)];
    self.armImg.image = [UIImage imageNamed:@"pic"];
    self.armImg.alpha = 0;
    [self addSubview:self.armImg];



    [self performSelector:@selector(secondAnimation) withObject:nil afterDelay:3];

}

- (void)tapMeasure{

    self.startMeasure();

}

- (void)secondAnimation{

    [self.circleImg removeFromSuperview];
    [self.staticIcon removeFromSuperview];
    self.contectLabel.alpha = 0;

    [self performSelector:@selector(thirdAnimation) withObject:nil afterDelay:0.5];

    [self performSelector:@selector(armAnimation) withObject:nil afterDelay:0.1];


    [UIView animateWithDuration:1 animations:^{

        self.bottomView.frame = CGRectMake(0, self.frame.size.height - 250, self.frame.size.width, 250);
    } completion:^(BOOL finished) {

    }];


}

- (void)armAnimation{

    [UIView animateWithDuration:0.5 animations:^{

        self.armImg.alpha = 1;
        self.contectLabel.alpha = 1;
        self.armImg.frame = CGRectMake((self.frame.size.width - 360 ) / 2, 90, 360, 250);
        self.contectLabel.text = @"如图所示戴好袖带";
        self.contectLabel.textColor = [UIColor colorWithHexString:@"6d6d6d"];

    } completion:nil];

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

}


- (void)firstAnimation{

    //    [UIView animateWithDuration:1.5 animations:^{
    //
    //        self.circleImg.transform = CGAffineTransformMakeRotation(-M_PI * 2);
    //
    //    } completion:^(BOOL finished) {
    //
    //    }];




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


@end
