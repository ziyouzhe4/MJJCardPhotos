//
//  MeasureBloodFaild.h
//  PhotoAnimationScrollDemo
//
//  Created by majianjie on 2018/3/14.
//  Copyright © 2018年 MKJING. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReConnectMeasureAction)();

@interface MeasureBloodFaild : UIView

@property (weak, nonatomic) IBOutlet UIButton *reConnectBtn;

@property (nonatomic,copy)ReConnectMeasureAction reconnectMeasure;

+ (instancetype)loadFaildView;

@end
