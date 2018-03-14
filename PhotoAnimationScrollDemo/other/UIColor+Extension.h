//
//  UIColor+Extension.h
//  chronos_patient
//
//  Created by liang on 16/3/29.
//  Copyright © 2016年 ihealth_chronos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
/**
 *  加载16进制的颜色
 *
 *  @param stringToConvert 16进制字符串
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
@end
