//
//  RotateView.m
//  Progress
//
//  Created by G on 19/5/29.
//  Copyright © 2019年 G. All rights reserved.
//

#import "RotateView.h"

#define RotateViewMargin 10
#define RotateColor [UIColor colorWithRed:0/255.0 green:190/255.0 blue:255/255.0 alpha:1]

@implementation RotateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - RotateViewMargin;
    
    // 背景
    [[UIColor redColor] set];
    CGFloat lineW = MAX(rect.size.width, rect.size.height) * 0.5;
    CGContextSetLineWidth(context, lineW);
    CGContextAddArc(context, xCenter, yCenter, radius + lineW * 0.5 + 5, 0, M_PI * 2, 1);
    CGContextStrokePath(context);

    // 进程
    [RotateColor set];
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, xCenter, yCenter);
    CGContextAddLineToPoint(context, xCenter, 0);
    CGFloat endAngle = -M_PI * 0.5 + _progress * M_PI * 2 + 0.001;
    CGContextAddArc(context, xCenter, yCenter, radius, -M_PI * 0.5, endAngle, 1);
    CGContextFillPath(context);
}



@end
