//
//  ZYYRulerValueView.m
//  ZYYRuler
//
//  Created by yuanye on 16/8/2.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import "ZYYRulerValueView.h"

@implementation ZYYRulerValueView

- (void)drawRect:(CGRect)rect {
    if (self.dircetion == ZYYRulerValueViewDirectionTop) {
        CGFloat height=  CGRectGetHeight(self.bounds);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.lineColor set];
        CGFloat startPoint = self.margin;
        CGFloat endPoint = 0;
        for (NSInteger i = 0 + self.minValue; i <= (self.maxValue - self.minValue) + self.minValue; i ++) {
            CGContextSetLineWidth(context, 1);
            startPoint = (i - self.minValue) * self.spacing + self.margin;
            if (i % 10 == 0) {
                endPoint = height - self.longLineLength;
                CGContextSetLineWidth(context, self.longLineWidth);
            } else if (i % 5 == 0) {
                endPoint = height - self.middleLineLength;
                CGContextSetLineWidth(context, self.middleLineWidth);
            } else {
                endPoint = height - self.shortLineLength;
                CGContextSetLineWidth(context, self.shortLineWidth);
            }
            CGContextMoveToPoint(context, startPoint, height);
            CGContextAddLineToPoint(context, startPoint, endPoint);
            CGContextStrokePath(context);
        }
        if (self.isShowHorizonalLine) {
            CGContextSetLineWidth(context, 1);
            CGContextMoveToPoint(context, self.margin, height);
            CGContextAddLineToPoint(context, startPoint, height);
            CGContextStrokePath(context);
        }
    } else if (self.dircetion == ZYYRulerValueViewDirectionBottom) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.lineColor set];
        CGFloat startPoint = self.margin;
        CGFloat endPoint = 0;
        for (NSInteger i = 0 + self.minValue; i <= (self.maxValue - self.minValue) + self.minValue; i ++) {
            CGContextSetLineWidth(context, 1);
            startPoint = (i - self.minValue) * self.spacing + self.margin;
            if (i % 10 == 0) {
                endPoint = self.longLineLength;
                CGContextSetLineWidth(context, self.longLineWidth);
            } else if (i % 5 == 0) {
                endPoint = self.middleLineLength;
                CGContextSetLineWidth(context, self.middleLineWidth);
            } else {
                endPoint = self.shortLineLength;
                CGContextSetLineWidth(context, self.shortLineWidth);
            }
            CGContextMoveToPoint(context, startPoint, 0);
            CGContextAddLineToPoint(context, startPoint, endPoint);
            CGContextStrokePath(context);
        }
        if (self.isShowHorizonalLine) {
            CGContextSetLineWidth(context, 1);
            CGContextMoveToPoint(context, self.margin, 0);
            CGContextAddLineToPoint(context, startPoint, 0);
            CGContextStrokePath(context);
        }
    }
}

#pragma mark - setter and getter

- (UIColor *)lineColor {
    if (!_lineColor) {
        _lineColor = [UIColor lightGrayColor];
    }
    return _lineColor;
}

- (NSInteger)minValue {
    if (!_minValue) {
        _minValue = 0;
    }
    return _minValue;
}

- (NSInteger)maxValue {
    if (!_maxValue) {
        _maxValue = 100;
    }
    return _maxValue;
}

- (CGFloat)spacing {
    if (!_spacing) {
        _spacing = 5.0;
    }
    return _spacing;
}

- (CGFloat)margin {
    if (!_margin) {
        _margin = 0.0;
    }
    return _margin;
}

- (CGFloat)shortLineLength {
    if (!_shortLineLength) {
        _shortLineLength = 6.0;
    }
    return _shortLineLength;
}

- (CGFloat)middleLineLength {
    if (!_middleLineLength) {
        _middleLineLength = 6.0;
    }
    return _middleLineLength;
}

- (CGFloat)longLineLength {
    if (!_longLineLength) {
        _longLineLength = 9.0;
    }
    return _longLineLength;
}

- (CGFloat)shortLineWidth {
    if (!_shortLineWidth) {
        _shortLineWidth = 1.5;
    }
    return _shortLineWidth;
}

- (CGFloat)middleLineWidth {
    if (!_middleLineWidth) {
        _middleLineWidth = 1.5;
    }
    return _middleLineWidth;
}

- (CGFloat)longLineWidth {
    if (!_longLineWidth) {
        _longLineWidth = 3.0;
    }
    return _longLineWidth;
}

- (ZYYRulerValueViewDirection)dircetion {
    if (!_dircetion) {
        _dircetion = ZYYRulerValueViewDirectionTop;
    }
    return _dircetion;
}

- (BOOL)isIsShowHorizonalLine {
    if (!_isShowHorizonalLine) {
        _isShowHorizonalLine = NO;
    }
    return _isShowHorizonalLine;
}

@end
