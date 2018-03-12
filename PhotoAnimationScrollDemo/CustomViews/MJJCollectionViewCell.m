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
}

@end
