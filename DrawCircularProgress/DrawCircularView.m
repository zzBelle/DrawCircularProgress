//
//  DrawCircularView.m
//  DrawCircularProgress
//
//  Created by 十月 on 2017/8/29.
//  Copyright © 2017年 Belle. All rights reserved.
//

#import "DrawCircularView.h"


#define DEGREES_2_RADIANS(x) (0.0174532925 * (x))
#define InternalDiameter 22
#define Small 14

@implementation DrawCircularView

@synthesize trackTintColor = _trackTintColor;
@synthesize progressTintColor =_progressTintColor;
@synthesize progress = _progress;

- (void)drawRect:(CGRect)rect {
//    圆心
    CGPoint centerPoint = CGPointMake(rect.size.height / 2, rect.size.width / 2);
//    半径
    CGFloat radius = MIN(rect.size.height, rect.size.width) / 2;
//    弧度
    CGFloat radians = DEGREES_2_RADIANS((self.progress*359.9)-90);
    CGFloat xOffset = radius*(1 + (1-11/radius)*cosf(radians));
    CGFloat yOffset = radius*(1 + (1-11/radius)*sinf(radians));
    CGPoint endPoint = CGPointMake(xOffset, yOffset);
    // 画圆
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.trackTintColor setFill];
    // 创建一个CGMutablePathRef 的可变路径，并返回其句柄  // 一个句柄是指使用的一个唯一的整数值
    CGMutablePathRef trackPath = CGPathCreateMutable();
    // 在路径上移动当前画笔的位置到一个点，这个点由CGPoint 类型的参数指定。
    CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
    // CGPathAddArc函数是通过圆心和半径定义一个圆，然后通过两个弧度确定一个弧线
    CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), DEGREES_2_RADIANS(-90), NO);
    // 把线从目前的点对`路径的当前子路径的起点和终点的路径。
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(context, trackPath);
    CGContextFillPath(context);
    CGPathRelease(trackPath);
    
    // 半径的线
    if (_progress !=0) {
        [self.progressTintColor setFill];
        CGMutablePathRef progressPath = CGPathCreateMutable();
        CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), radians, NO);
        CGPathCloseSubpath(progressPath);
        CGContextAddPath(context, progressPath);
        CGContextFillPath(context);
        CGPathRelease(progressPath);
    }
    // 起点处的圆
    [self.progressTintColor setFill];
    CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x - InternalDiameter/2, 0, InternalDiameter, InternalDiameter));
    CGContextFillPath(context);
    
    if (_progress !=0) {
        // 起点内部的小圆
        [[UIColor whiteColor] setFill];
        CGContextRef context2 = UIGraphicsGetCurrentContext();
        CGContextAddEllipseInRect(context2, CGRectMake(centerPoint.x - Small/2, 4, Small, Small));
        CGContextFillPath(context2);
        
        // 旋转的头部圆
        [self.progressTintColor setFill];
        CGContextAddEllipseInRect(context, CGRectMake(endPoint.x - InternalDiameter/2, endPoint.y - InternalDiameter/2, InternalDiameter, InternalDiameter));
        CGContextFillPath(context);
        
        [[UIColor whiteColor] setFill];
        CGContextRef context3 = UIGraphicsGetCurrentContext();
        CGContextAddEllipseInRect(context3, CGRectMake(centerPoint.x - Small/2, 4, Small, Small));
        CGContextFillPath(context3);
        
    }
    
    // 内部圆
    [[UIColor whiteColor] setFill];
    CGFloat innerRadius = radius - InternalDiameter;
    CGPoint newCenterPoint = CGPointMake(centerPoint.x - innerRadius, centerPoint.y - innerRadius);
    CGContextAddEllipseInRect(context, CGRectMake(newCenterPoint.x, newCenterPoint.y, innerRadius * 2, innerRadius * 2));
    CGContextFillPath(context);
}


#pragma mark - Property Methods
- (UIColor *)trackTintColor {
    if (!_trackTintColor){
        _trackTintColor = self.backgroundColor;
    }
    
    return _trackTintColor;
}

- (void)setProgress:(float)progress {
    
    _progress = progress;
    [self setNeedsDisplay];
}
@end
