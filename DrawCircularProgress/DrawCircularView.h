//
//  DrawCircularView.h
//  DrawCircularProgress
//
//  Created by 十月 on 2017/8/29.
//  Copyright © 2017年 Belle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawCircularView : UIView

@property (nonatomic , strong) UIColor *trackTintColor;
@property (nonatomic , strong) UIColor *progressTintColor;
@property (nonatomic) float progress;

@end
