//
//  MeasureBloodFaild.m
//  PhotoAnimationScrollDemo
//
//  Created by majianjie on 2018/3/14.
//  Copyright © 2018年 MKJING. All rights reserved.
//

#import "MeasureBloodFaild.h"

@implementation MeasureBloodFaild

+ (instancetype)loadFaildView{

   MeasureBloodFaild  *loadFaildView = [[[NSBundle mainBundle] loadNibNamed:@"MeasureBloodFaild" owner:self options:nil]lastObject];
    return loadFaildView;

}

- (void)awakeFromNib{

    [super awakeFromNib];

    self.backgroundColor = [UIColor whiteColor];
    
    self.reConnectBtn.layer.cornerRadius = 22;
    self.reConnectBtn.layer.masksToBounds = YES;

    self.reConnectBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.reConnectBtn.layer.borderWidth = 1;

    

}

- (IBAction)reconnectAction:(id)sender {

    self.reconnectMeasure();
}


@end
