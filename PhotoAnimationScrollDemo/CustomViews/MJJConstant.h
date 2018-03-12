//
//  MJJConstant.h
//  PhotoAnimationScrollDemo
//
//  Created by majianjie on 16/8/10.
//  Copyright © 2016年 majianjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RGB(r,g,b,a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define SCREEN_WIDTH [UIScreen  mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

UIKIT_EXTERN const CGFloat MJJLineSpacing; // item间距
UIKIT_EXTERN const CGFloat MJJZoomScale; // 缩放比例
UIKIT_EXTERN const CGFloat MJJMinZoomScale; // 最小缩放比例

