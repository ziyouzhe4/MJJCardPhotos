//
//  MJJMainPopoutView.h
//  PhotoAnimationScrollDemo
//
//  Created by majianjie on 18/3/12.
//  Copyright © 2016年 majianjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJJItemModel.h"
@protocol MJJMainPopoutViewDelegate <NSObject>

// 点击血糖数据或者血压数据
- (void)clickActionBtn:(NSInteger)selectedIndex;

// 点击测量血糖或者测量血压
- (void)clickMeasure:(NSInteger)selectedIndex;

@end

@interface MJJMainPopoutView : UIView

@property (nonatomic,weak) id<MJJMainPopoutViewDelegate>delegate;
@property (nonatomic,strong) NSArray *dataSource;
- (void)showInSuperView:(UIView *)superView;

@property (nonatomic,assign)BOOL showRemindBtn;

//2 小时提醒按钮
@property (nonatomic,strong)UIButton *remindBtn;


@end
