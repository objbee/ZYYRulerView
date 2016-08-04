//
//  ZYYRulerView.h
//  ZYYRuler
//
//  Created by yuanye on 16/8/3.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYYRulerView;

typedef void (^rulerViewCurrentValueBlock)(NSNumber *value);

@protocol ZYYRulerViewDelegate <NSObject>
@optional
/**
 *  代理获取尺子当前指向的值
 *
 *  @param value 尺子当前指向的值
 */
- (void)zyy_rulerViewCurrentValue:(NSNumber *)value;

/**
 *  代理获取尺子当前指向的值
 *
 *  @param value     尺子当前指向的值
 *  @param rulerView ZYYRulerView
 */
- (void)zyy_rulerViewCurrentValue:(NSNumber *)value rulerView:(ZYYRulerView *)rulerView;
@end

@interface ZYYRulerView : UIView

// *--------------------------------------------------------------------------------*
// Usage: 尺子的最小值和最大值必须整形！例如需求为 0.1->10 可以设置 1->100, 在获取值之后 /10 即可
// *--------------------------------------------------------------------------------*

/**
 *  尺子最小值
 */
@property (assign, nonatomic) NSInteger rulerMinValue;
/**
 *  尺子最大值
 */
@property (assign, nonatomic) NSInteger rulerMaxValue;
/**
 *  刻度之间的距离
 */
@property (assign, nonatomic) NSInteger rulerSpacing;
/**
 *  尺子视图的背景色
 */
@property (strong, nonatomic) UIColor *rulerBackgroundColor;
/**
 *  尺子刻度线的颜色
 */
@property (strong, nonatomic) UIColor *rulerLineColor;
/**
 *  第一条刻度距离边缘的距离
 */
@property (assign, nonatomic) CGFloat rulerMargin;
/**
 *  普通短刻度的长度
 */
@property (assign, nonatomic) CGFloat rulerShortLineLength;
/**
 *  普通短刻度的宽度
 */
@property (assign, nonatomic) CGFloat rulerShortLineWidth;
/**
 *  %5==0 中刻度的长度
 */
@property (assign, nonatomic) CGFloat rulerMiddleLineLength;
/**
 *  %5==0 中刻度的宽度
 */
@property (assign, nonatomic) CGFloat rulerMiddleLineWidth;
/**
 *  %10==0 长刻度的长度
 */
@property (assign, nonatomic) CGFloat rulerLongLineLength;
/**
 *  %10==0 长刻度的宽度
 */
@property (assign, nonatomic) CGFloat rulerLongLineWidth;
/**
 *  是否显示尺子横线
 */
@property (assign, nonatomic) BOOL isShowHorizonalLine;
/**
 *  三角形指示视图的尺寸
 */
@property (assign, nonatomic) CGSize rulerTriangleViewSize;
/**
 *  三角形指示视图的颜色
 */
@property (strong, nonatomic) UIColor *rulerTriangleViewColor;

@property (copy, nonatomic) rulerViewCurrentValueBlock currentValueBlock;
@property (weak, nonatomic) id <ZYYRulerViewDelegate> delegate;

/**
 *  设置尺子默认指示的值
 *
 *  @param value 指示值
 */
- (void)updateCurrentValue:(CGFloat)value;

/**
 *  Block获取尺子当前指向的值
 *
 *  @param rulerViewCurrentValue 尺子当前指向的值
 */
- (void)rulerViewCurrentValueWithBlock:(rulerViewCurrentValueBlock)currentValueBlock;

@end
