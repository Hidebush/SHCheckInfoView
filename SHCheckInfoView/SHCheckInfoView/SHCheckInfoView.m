//
//  SHCheckInfoView.m
//  SHCheckInfoView
//
//  Created by lvshaohua on 2017/5/19.
//  Copyright © 2017年 lvshaohua. All rights reserved.
//

#import "SHCheckInfoView.h"

@interface SHCheckInfoView () <CAAnimationDelegate>
{
    UIView *_logoView;
}
@property (nonatomic, copy) void (^complete) (BOOL isFinish);

@end

@implementation SHCheckInfoView

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor
{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        _lineWidth = lineWidth;
        _lineColor = lineColor;
    }
    return self;
}

- (void)showAnimationWithState:(XYProgressResultState)state duration:(NSTimeInterval)duration complete:(void (^) (BOOL isFinish))complate
{
    if (_logoView != nil) {
        [self removeView];
    }
    _logoView = [[UIView alloc] initWithFrame:self.bounds];
    CGPoint centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:self.frame.size.width/2.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    //对拐角和中点处理
    path.lineCapStyle  = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    // 添加绘制状态路径
    switch (state) {
        case XYProgressResult_Success:
            path = [self drawInformTickWithPath:path];
            break;
        case XYProgressResult_Failed:
            path = [self drawInformCrossWithPath:path];
        default:
            break;
    }
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = _fillColor ? _fillColor.CGColor : [UIColor clearColor].CGColor;
    layer.strokeColor = _lineColor ? _lineColor.CGColor : [UIColor redColor].CGColor;
    layer.lineWidth =  _lineWidth ? _lineWidth : 3.0;
    layer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = duration;
    animation.delegate = self;
    
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    [_logoView.layer addSublayer:layer];
    [self addSubview:_logoView];
    if (complate != nil) {
        _complete = complate;
    }
}

- (UIBezierPath *)drawInformTickWithPath:(UIBezierPath *)path
{
    //对号第一部分直线的起始
    // 对号第一部分起始点
    CGPoint checkPoint1 = CGPointMake(self.frame.size.width/15.0*6, self.frame.size.height/4.0*3);
    // 对号第二部分起始点
    CGPoint checkPoint2 = CGPointMake(self.frame.size.width/10.0*8, self.frame.size.height*0.3);
    
    // 绘制对号
    [path moveToPoint:CGPointMake(self.frame.size.width/5, self.frame.size.width/2)];
    [path addLineToPoint:checkPoint1];
    [path addLineToPoint:checkPoint2];
    return path;
}

- (UIBezierPath *)drawInformCrossWithPath:(UIBezierPath *)path
{
    double cl = (self.frame.size.height * sqrt(2.0)) * 0.5;
    double scl = cl - self.frame.size.height * 0.5;
    double cwh = scl / sqrt(2.0) + (self.frame.size.width * 0.14);
    [path moveToPoint:CGPointMake(cwh, cwh)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - cwh, self.frame.size.height - cwh)];
    [path moveToPoint:CGPointMake(self.frame.size.width - cwh, cwh)];
    [path addLineToPoint:CGPointMake(cwh, self.frame.size.height - cwh)];
    return path;
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (_complete) {
        _complete(flag);
    }    
    [self performSelector:@selector(removeView) withObject:nil afterDelay:2];
    
}

- (void)removeView
{
    [_logoView removeFromSuperview];
    _logoView = nil;
}


@end
