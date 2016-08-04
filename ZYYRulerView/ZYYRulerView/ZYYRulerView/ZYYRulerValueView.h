//
//  ZYYRulerValueView.h
//  ZYYRuler
//
//  Created by yuanye on 16/8/2.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZYYRulerValueViewDirectionTop,
    ZYYRulerValueViewDirectionBottom
} ZYYRulerValueViewDirection;

@interface ZYYRulerValueView : UIView
@property (strong, nonatomic) UIColor *lineColor;
@property (assign, nonatomic) NSInteger minValue;
@property (assign, nonatomic) NSInteger maxValue;
@property (assign, nonatomic) CGFloat spacing;
@property (assign, nonatomic) CGFloat margin;
@property (assign, nonatomic) CGFloat shortLineLength;
@property (assign, nonatomic) CGFloat shortLineWidth;
@property (assign, nonatomic) CGFloat middleLineLength;
@property (assign, nonatomic) CGFloat middleLineWidth;
@property (assign, nonatomic) CGFloat longLineLength;
@property (assign, nonatomic) CGFloat longLineWidth;
@property (assign, nonatomic) ZYYRulerValueViewDirection dircetion;
@property (assign, nonatomic) BOOL isShowHorizonalLine;
@end
