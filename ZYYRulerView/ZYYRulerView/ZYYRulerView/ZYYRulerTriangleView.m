//
//  ZYYRulerMarkView.m
//  ZYYRuler
//
//  Created by yuanye on 16/8/2.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import "ZYYRulerTriangleView.h"

@implementation ZYYRulerTriangleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height=  CGRectGetHeight(self.bounds);
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint centerPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(0, 0);
    
    if (self.direction == ZYYRulerTriangleViewDirectionTop) {
        startPoint = CGPointMake(0, height);
        centerPoint = CGPointMake(width/2.0, 0);
        endPoint = CGPointMake(width, height);
    } else if (self.direction == ZYYRulerTriangleViewDirectionBottom ) {
        startPoint = CGPointMake(0, 0);
        centerPoint = CGPointMake(width/2.0, height);
        endPoint = CGPointMake(width, 0);
    } else if (self.direction == ZYYRulerTriangleViewDirectionLeft) {
        startPoint = CGPointMake(width, 0);
        centerPoint = CGPointMake(0, height/2.0);
        endPoint = CGPointMake(width, height);
    } else if (self.direction == ZYYRulerTriangleViewDirectionRight) {
        startPoint = CGPointMake(0, 0);
        centerPoint = CGPointMake(width, height/2.0);
        endPoint = CGPointMake(0, height);
    }
    
    [self.fillColor set];
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, centerPoint.x, centerPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGContextFillPath(context);
}

#pragma mark - setter and getter

- (UIColor *)fillColor {
    if (!_fillColor) {
        _fillColor = [UIColor redColor];
    }
    return _fillColor;
}

- (ZYYRulerTriangleViewDirection)direction {
    if (!_direction) {
        _direction = ZYYRulerTriangleViewDirectionTop;
    }
    return _direction;
}

@end
