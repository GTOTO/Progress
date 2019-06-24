//
//  ViewController.m
//  Progress
//
//  Created by G on 19/5/27.
//  Copyright © 2019年 G. All rights reserved.
//

#import "ViewController.h"
#import "WaveView.h"
#import "CircleView.h"
#import "StripView.h"
#import "RotateView.h"

@interface ViewController ()

@property(nonatomic, strong) WaveView *waveView;
@property(nonatomic, strong) CircleView *circleView;
@property(nonatomic, strong) StripView *stripView;
@property(nonatomic, strong) RotateView *rotateView;

@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) dispatch_source_t gcdTimer;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
    
    
    [self addTimer];
}


/**
 图文混排
 */
- (void)imageAndText
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 400, 80)];
    
    
    [self.view addSubview:titleLabel];
    
    
    // 1.创建一个富文本
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"哈哈哈哈哈哈哈123456"];
    // 2.修改富文本中的不通过文字样式
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(1, 3)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(1, 3)];
    // 设置数字为红色
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7, 6)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(7, 6)];
    
    // 1.添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:@"4343"];
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, 30, 30);
    // 创建带有图片的富文本
    NSAttributedString *attri1 = [NSAttributedString attributedStringWithAttachment:attch];
    [attri appendAttributedString:attri1];
    
    titleLabel.attributedText = attri;
    

}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
////    static dispatch_once_t onceToken;
////    dispatch_once(&onceToken, ^{
////        [self addTimer];
////    });
//    
//    [self createGCDTimer];
//}

- (void)createGCDTimer
{
    /** 创建定时器对象
     * para1: DISPATCH_SOURCE_TYPE_TIMER 为定时器类型
     * para2-3: 中间两个参数对定时器无用
     * para4: 最后为在什么调度队列中使用
     */
    _gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    
    /** 设置定时器
     * para2: 任务开始时间
     * para3: 任务的间隔
     * para4: 可接受的误差时间，设置0即不允许出现误差
     * Tips: 单位均为纳秒
     */
    dispatch_source_set_timer(_gcdTimer, DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC, 0);
    
    /** 设置定时器任务
     * 可以通过block方式
     * 也可以通过C函数方式
     */
    dispatch_source_set_event_handler(_gcdTimer, ^{
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _waveView.progress += 0.01;
            _circleView.progress += 0.01;
            _stripView.progress += 0.01;
            _rotateView.progress += 0.01;
            
            if (_waveView.progress >= 1) {
                // 终止定时器
                dispatch_suspend(_gcdTimer);
            }
        });
    });
    
    // 启动任务，GCD计时器创建后需要手动启动
    dispatch_resume(_gcdTimer);
}

- (void)initView
{
    _waveView = [[WaveView alloc] initWithFrame:CGRectMake(50, 70, 100, 100)];
    
    [self.view addSubview:_waveView];
    
    
    _circleView = [[CircleView alloc] initWithFrame:CGRectMake(250, 70, 100, 100)];
    
    [self.view addSubview:_circleView];
    
    
    _stripView = [[StripView alloc] initWithFrame:CGRectMake(50, 300, 100, 20)];
    
    [self.view addSubview:_stripView];
    
    
    _rotateView = [[RotateView alloc] initWithFrame:CGRectMake(250, 300, 100, 100)];
    
    [self.view addSubview:_rotateView];
}

- (void)addTimer
{
    /**
     NSTimer
     @param timerWithTimeInterval 每隔多久调用一次
     */
//    _timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self timerAction];
    }];
}

- (void)timerAction
{
    _waveView.progress += 0.01;
    _circleView.progress += 0.01;
    _stripView.progress += 0.01;
    _rotateView.progress += 0.01;
    
    if (_waveView.progress >= 1) {
        [self timerRemove];
    }
    
    
}

- (void)timerRemove
{
    [_timer invalidate];
    _timer = nil;
}

@end
