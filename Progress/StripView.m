//
//  StripView.m
//  Progress
//
//  Created by G on 19/5/29.
//  Copyright © 2019年 G. All rights reserved.
//

#import "StripView.h"

#define StripBorderWidth 2.0f
#define StripPadding 0.0f
#define StripColor [UIColor colorWithRed:0/255.0 green:190/255.0 blue:255/255.0 alpha:1]


@interface StripView ()

@property(nonatomic, strong) UIView *progressView;

@end

@implementation StripView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    UIView *borderView = [[UIView alloc] initWithFrame:self.bounds];
    borderView.backgroundColor = [UIColor whiteColor];
    borderView.layer.cornerRadius = self.frame.size.height * 0.5;
    borderView.layer.borderWidth = StripBorderWidth;
    borderView.layer.borderColor = [StripColor CGColor];
    borderView.layer.masksToBounds = YES;
    
    [self addSubview:borderView];
    
    
    _progressView = [UIView new];
    _progressView.backgroundColor = StripColor;
    _progressView.layer.cornerRadius = (self.bounds.size.height - (StripBorderWidth + StripPadding) * 2) * 0.5;
    _progressView.layer.masksToBounds = YES;
    
    [self addSubview:_progressView];
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    CGFloat margin = StripBorderWidth + StripPadding;
    CGFloat maxWidth = self.bounds.size.width - margin * 2;
    CGFloat heigth = self.bounds.size.height - margin * 2;
    
    _progressView.frame = CGRectMake(margin, margin, maxWidth * progress, heigth);
}

@end
