//
//  MeasureBloodView.h
//  PhotoAnimationScrollDemo
//
//  Created by majianjie on 2018/3/14.
//  Copyright © 2018年 MKJING. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StartMeasure)();

@interface MeasureBloodView : UIView


@property (nonatomic,copy)StartMeasure startMeasure;

- (void)connectXyanimation;

@end
