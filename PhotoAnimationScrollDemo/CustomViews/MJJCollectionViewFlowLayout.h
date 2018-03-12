//
//  MJJCollectionViewFlowLayout.h
//  PhotoAnimationScrollDemo
//
//  Created by majianjie on 18/3/12.
//  Copyright © 2016年 majianjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJJCollectionViewFlowLayoutDelegate <NSObject>

- (void)collectioViewScrollToIndex:(NSInteger)index;

@end

@interface MJJCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) id<MJJCollectionViewFlowLayoutDelegate>delegate;

@property (nonatomic,assign) BOOL needAlpha;

@end
