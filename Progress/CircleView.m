//
//  CircleView.m
//  Progress
//
//  Created by G on 19/5/29.
//  Copyright © 2019年 G. All rights reserved.
//

#import "CircleView.h"

#define CircleLineWidth 10.0f
#define CircleFont [UIFont boldSystemFontOfSize:26.0f]
#define CircleColor [UIColor colorWithRed:0/255.0 green:190/255.0 blue:255/255.0 alpha:1]


@interface CircleView ()

@property(nonatomic, strong) UILabel *valueLabel;

@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:self.bounds];
    valueLabel.backgroundColor = [UIColor clearColor];
    valueLabel.text = @"0%";
    valueLabel.textColor = CircleColor;
    valueLabel.textAlignment = NSTextAlignmentCenter;
    valueLabel.font = CircleFont;
    
    [self addSubview:valueLabel];
    self.valueLabel = valueLabel;
}

- (void)drawRect:(CGRect)rect
{
    // 路径
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = CircleLineWidth;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    
    [CircleColor set];
    
    // 半径
    CGFloat radius = (MIN(rect.size.width, rect.size.height) - CircleLineWidth) * 0.5;
    // 画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [bezierPath addArcWithCenter:CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5) radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2 * _progress clockwise:YES];
    
    [bezierPath stroke];

}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    self.valueLabel.text = [NSString stringWithFormat:@"%d%%", (int)floor(progress * 100)];
    
    [self setNeedsDisplay];
}

@end
