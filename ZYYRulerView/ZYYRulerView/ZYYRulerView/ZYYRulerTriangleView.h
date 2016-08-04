//
//  ZYYRulerMarkView.h
//  ZYYRuler
//
//  Created by yuanye on 16/8/2.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZYYRulerTriangleViewDirectionTop,
    ZYYRulerTriangleViewDirectionBottom,
    ZYYRulerTriangleViewDirectionLeft,
    ZYYRulerTriangleViewDirectionRight
} ZYYRulerTriangleViewDirection;

@interface ZYYRulerTriangleView : UIView
@property (strong, nonatomic) UIColor *fillColor;
@property (assign, nonatomic) ZYYRulerTriangleViewDirection direction;
@end
