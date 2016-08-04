//
//  ZYYRulerView.m
//  ZYYRuler
//
//  Created by yuanye on 16/8/3.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import "ZYYRulerView.h"
#import "ZYYRulerValueView.h"
#import "ZYYRulerTriangleView.h"
#import "ZYYRulerViewConst.h"

@interface ZYYRulerView () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) ZYYRulerValueView *valueView;
@property (strong, nonatomic) ZYYRulerTriangleView *triangleView;
@property (assign, nonatomic) CGFloat currentValue;
@end

@implementation ZYYRulerView

@synthesize rulerBackgroundColor = _rulerBackgroundColor;
@synthesize rulerLineColor = _rulerLineColor;
@synthesize rulerMinValue = _rulerMinValue;
@synthesize rulerMaxValue = _rulerMaxValue;
@synthesize rulerSpacing = _rulerSpacing;
@synthesize rulerMargin = _rulerMargin;
@synthesize rulerShortLineWidth = _rulerShortLineWidth;
@synthesize rulerShortLineLength = _rulerShortLineLength;
@synthesize rulerMiddleLineWidth = _rulerMiddleLineWidth;
@synthesize rulerMiddleLineLength = _rulerMiddleLineLength;
@synthesize rulerLongLineWidth = _rulerLongLineWidth;
@synthesize rulerLongLineLength = _rulerLongLineLength;
@synthesize rulerTriangleViewSize = _rulerTriangleViewSize;
@synthesize rulerTriangleViewColor = _rulerTriangleViewColor;
@synthesize isShowHorizonalLine = _isShowHorizonalLine;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.triangleView];
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.valueView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.triangleView.frame = CGRectMake((self.bounds.size.width - self.rulerTriangleViewSize.width)/2.0, self.bounds.size.height - self.rulerTriangleViewSize.height, self.rulerTriangleViewSize.width, self.rulerTriangleViewSize.height);
    self.scrollView.frame = self.bounds;
    CGFloat totalWidth = self.rulerSpacing * (self.rulerMaxValue - self.rulerMinValue) + self.rulerMargin * 2;
    self.valueView.frame = CGRectMake(0, 0, totalWidth, self.bounds.size.height - self.rulerTriangleViewSize.height);
    self.scrollView.contentSize = CGSizeMake(totalWidth, 0);
}

- (void)drawRect:(CGRect)rect {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = @[(id)[[UIColor whiteColor] colorWithAlphaComponent:0.75f].CGColor,
                        (id)[[UIColor whiteColor] colorWithAlphaComponent:0.0f].CGColor,
                        (id)[[UIColor whiteColor] colorWithAlphaComponent:0.75f].CGColor];
    gradient.locations  = @[@(0), @(0.5)];
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    [self.layer addSublayer:gradient];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    self.currentValue = (offsetX + scrollView.contentInset.left) / self.rulerSpacing + self.rulerMinValue;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //NSLog(@"currentValue = %@", @(self.currentValue));
    if (self.delegate && [self.delegate respondsToSelector:@selector(zyy_rulerViewCurrentValue:)]) {
        [self.delegate zyy_rulerViewCurrentValue:@(self.currentValue)];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(zyy_rulerViewCurrentValue:rulerView:)]) {
        [self.delegate zyy_rulerViewCurrentValue:@(self.currentValue) rulerView:self];
    }
    if (self.currentValueBlock) {
        self.currentValueBlock(@(self.currentValue));
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGPoint originalTargetContentOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y);
    CGFloat offsetX = originalTargetContentOffset.x;
    CGFloat result = round((offsetX + scrollView.contentInset.left) / self.rulerSpacing) * self.rulerSpacing;
    *targetContentOffset = CGPointMake(result - scrollView.contentInset.left, originalTargetContentOffset.y);
}

#pragma mark - public

- (void)updateCurrentValue:(CGFloat)value {
    if (value > self.rulerMaxValue || value < self.rulerMinValue) {
        return;
    }
    [self layoutIfNeeded];
    [self setNeedsLayout];
    self.currentValue = value;
    CGFloat offsetX = (self.currentValue - self.rulerMinValue) * self.rulerSpacing - self.scrollView.contentInset.left;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)rulerViewCurrentValueWithBlock:(rulerViewCurrentValueBlock)currentValueBlock {
    self.currentValueBlock = currentValueBlock;
}

#pragma mark - setter and getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (ZYYRulerValueView *)valueView {
    if (!_valueView) {
        _valueView = [[ZYYRulerValueView alloc] init];
        _valueView.contentMode = UIViewContentModeRedraw;
        _valueView.backgroundColor = self.rulerBackgroundColor;
        _valueView.lineColor = self.rulerLineColor;
        _valueView.spacing = self.rulerSpacing;
        _valueView.margin = self.rulerMargin;
        _valueView.shortLineWidth = self.rulerShortLineWidth;
        _valueView.shortLineLength = self.rulerShortLineLength;
        _valueView.middleLineWidth = self.rulerMiddleLineWidth;
        _valueView.middleLineLength = self.rulerMiddleLineLength;
        _valueView.longLineWidth = self.rulerLongLineWidth;
        _valueView.longLineLength = self.rulerLongLineLength;
        _valueView.minValue = self.rulerMinValue;
        _valueView.maxValue = self.rulerMaxValue;
        _valueView.isShowHorizonalLine = self.isShowHorizonalLine;
    }
    return _valueView;
}

- (ZYYRulerTriangleView *)triangleView {
    if (!_triangleView) {
        _triangleView = [[ZYYRulerTriangleView alloc] init];
        _triangleView.backgroundColor = [UIColor clearColor];
        _triangleView.fillColor = self.rulerTriangleViewColor;
        _triangleView.direction = ZYYRulerTriangleViewDirectionTop;
    }
    return _triangleView;
}

- (CGFloat)currentValue {
    if (!_currentValue) {
        _currentValue = 0.0;
    }
    return _currentValue;
}

- (void)setRulerBackgroundColor:(UIColor *)rulerBackgroundColor {
    _rulerBackgroundColor = rulerBackgroundColor;
    _valueView.backgroundColor = rulerBackgroundColor;
}

- (UIColor *)rulerBackgroundColor {
    if (!_rulerBackgroundColor) {
        _rulerBackgroundColor = [UIColor clearColor];
    }
    return _rulerBackgroundColor;
}

- (void)setRulerLineColor:(UIColor *)rulerLineColor {
    _rulerLineColor = rulerLineColor;
    _valueView.lineColor = rulerLineColor;
}

- (UIColor *)rulerLineColor {
    if (!_rulerLineColor) {
        _rulerLineColor = kRulerDefaultLineColor;
    }
    return _rulerLineColor;
}

- (void)setRulerMinValue:(NSInteger)rulerMinValue {
    _rulerMinValue = rulerMinValue;
    _valueView.minValue = rulerMinValue;
}

- (NSInteger)rulerMinValue {
    if (!_rulerMinValue) {
        _rulerMinValue  = 0;
    }
    return _rulerMinValue;
}

- (void)setRulerMaxValue:(NSInteger)rulerMaxValue {
    _rulerMaxValue = rulerMaxValue;
    _valueView.maxValue = rulerMaxValue;
}

- (NSInteger)rulerMaxValue {
    if (!_rulerMaxValue) {
        _rulerMaxValue = 100;
    }
    return _rulerMaxValue;
}

- (void)setRulerSpacing:(NSInteger)rulerSpacing {
    _rulerSpacing = rulerSpacing;
    _valueView.spacing = rulerSpacing;
}

- (NSInteger)rulerSpacing {
    if (!_rulerSpacing) {
        _rulerSpacing = 5;
    }
    return _rulerSpacing;
}

- (void)setRulerMargin:(CGFloat)rulerMargin {
    _rulerMargin = rulerMargin;
    _valueView.margin = rulerMargin;
}

- (CGFloat)rulerMargin {
    if (!_rulerMargin) {
        _rulerMargin = self.bounds.size.width/2.0;
    }
    return _rulerMargin;
}

- (void)setRulerShortLineWidth:(CGFloat)rulerShortLineWidth {
    _rulerShortLineWidth = rulerShortLineWidth;
    _valueView.shortLineWidth = rulerShortLineWidth;
}

- (CGFloat)rulerShortLineWidth {
    if (!_rulerShortLineWidth) {
        _rulerShortLineWidth = 1.5;
    }
    return _rulerShortLineWidth;
}

- (void)setRulerShortLineLength:(CGFloat)rulerShortLineLength {
    _rulerShortLineLength = rulerShortLineLength;
    _valueView.shortLineLength = rulerShortLineLength;
}

- (CGFloat)rulerShortLineLength {
    if (!_rulerShortLineLength) {
        _rulerShortLineLength = 6.0;
    }
    return _rulerShortLineLength;
}

- (void)setRulerMiddleLineWidth:(CGFloat)rulerMiddleLineWidth {
    rulerMiddleLineWidth = rulerMiddleLineWidth;
    _valueView.middleLineWidth = rulerMiddleLineWidth;
}

- (CGFloat)rulerMiddleLineWidth {
    if (!_rulerMiddleLineWidth) {
        _rulerMiddleLineWidth = 1.5;
    }
    return _rulerMiddleLineWidth;
}

- (void)setRulerMiddleLineLength:(CGFloat)rulerMiddleLineLength {
    _rulerMiddleLineLength = rulerMiddleLineLength;
    _valueView.middleLineLength = rulerMiddleLineLength;
}

- (CGFloat)rulerMiddleLineLength {
    if (!_rulerMiddleLineLength) {
        _rulerMiddleLineLength = 6.0;
    }
    return _rulerMiddleLineLength;
}

- (void)setRulerLongLineWidth:(CGFloat)rulerLongLineWidth {
    _rulerLongLineWidth = rulerLongLineWidth;
    _valueView.longLineWidth = rulerLongLineWidth;
}

- (CGFloat)rulerLongLineWidth {
    if (!_rulerLongLineWidth) {
        _rulerLongLineWidth = 3.0;
    }
    return _rulerLongLineWidth;
}

- (void)setRulerLongLineLength:(CGFloat)rulerLongLineLength {
    _rulerLongLineLength = rulerLongLineLength;
    _valueView.longLineLength = rulerLongLineLength;
}

- (CGFloat)rulerLongLineLength {
    if (!_rulerLongLineLength) {
        _rulerLongLineLength = 9.0;
    }
    return _rulerLongLineLength;
}

- (void)setRulerTriangleViewSize:(CGSize)rulerTriangleViewSize {
    _rulerTriangleViewSize = rulerTriangleViewSize;
}

- (CGSize)rulerTriangleViewSize {
    if (!_rulerTriangleViewSize.width || !_rulerTriangleViewSize.height) {
        _rulerTriangleViewSize = CGSizeMake(8, 8);
    }
    return _rulerTriangleViewSize;
}

- (void)setRulerTriangleViewColor:(UIColor *)rulerTriangleViewColor {
    _rulerTriangleViewColor = rulerTriangleViewColor;
    _triangleView.fillColor = rulerTriangleViewColor;
}

- (UIColor *)rulerTriangleViewColor {
    if (!_rulerTriangleViewColor) {
        _rulerTriangleViewColor = kRulerDefaultFillColor;
    }
    return _rulerTriangleViewColor;
}

- (void)setIsShowHorizonalLine:(BOOL)isShowHorizonalLine {
    _isShowHorizonalLine = isShowHorizonalLine;
    _valueView.isShowHorizonalLine = isShowHorizonalLine;
}

- (BOOL)isShowHorizonalLine {
    if (!_isShowHorizonalLine) {
        _isShowHorizonalLine = NO;
    }
    return _isShowHorizonalLine;
}

@end
