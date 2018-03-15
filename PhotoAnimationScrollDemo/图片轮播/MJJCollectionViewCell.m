//
//  MJJCollectionViewCell.m
//  PhotoAnimationScrollDemo
//
//  Created by majianjie on 18/3/12.
//  Copyright © 2016年 majianjie. All rights reserved.
//

#import "MJJCollectionViewCell.h"
#import "MJJConstant.h"

@implementation MJJCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = [UIColor redColor];
    self.contentView.backgroundColor = [UIColor redColor];

    self.layer.cornerRadius = SCREEN_WIDTH / 4;
    self.layer.masksToBounds = YES;

    [self startCLAnimation];
}

- (void)startCLAnimation {
    CABasicAnimation * animation_basic = [CABasicAnimation animation];
    animation_basic = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation_basic.fromValue = [NSNumber numberWithFloat:1.0f];
    animation_basic.toValue = [NSNumber numberWithFloat:1.05f];
    animation_basic.duration = 3;
    animation_basic.repeatCount = MAXFLOAT;
    animation_basic.autoreverses = YES;
    animation_basic.speed = 2;
    animation_basic.removedOnCompletion = NO;
    animation_basic.fillMode = kCAFillModeForwards;
    animation_basic.beginTime = CACurrentMediaTime();
    [self.heroImageVIew.layer addAnimation:animation_basic forKey:@"key"];
    self.heroImageVIew.layer.shadowOpacity = 0.5;// 阴影透明度
    //    self.popView.layer.shadowColor = [UIColor colorWithHexString:@"001f76"].CGColor; // 阴影的颜色
    self.heroImageVIew.layer.shadowRadius = 10; //阴影扩散的范围控制
    self.heroImageVIew.layer.shadowOffset = CGSizeMake(1, 1); //阴影的范围
}

@end
