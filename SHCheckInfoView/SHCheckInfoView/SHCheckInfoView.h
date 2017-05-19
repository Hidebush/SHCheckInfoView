//
//  SHCheckInfoView.h
//  SHCheckInfoView
//
//  Created by lvshaohua on 2017/5/19.
//  Copyright © 2017年 lvshaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

// 设置动画效果样式
typedef enum{
    XYProgressResult_Success,
    XYProgressResult_Failed,
}XYProgressResultState;

@interface SHCheckInfoView : UIView

// 线条宽度，默认为3.0；
@property (nonatomic, assign) CGFloat lineWidth;

// 线条颜色，默认是redColor
@property (nonatomic, strong) UIColor *lineColor;

// 设置填充颜色，默认是clearColor；
@property (nonatomic, strong) UIColor *fillColor;

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;

/*
 *  state 成功或者失败状态，决定绘画样式。
 *  duration 动画时长。
 *  complate 动画结束时回调。
 */
- (void)showAnimationWithState:(XYProgressResultState)state duration:(NSTimeInterval)duration complete:(void (^) (BOOL isFinish))complate;

@end
