//
//  ViewController.m
//  ZYYRulerView
//
//  Created by yuanye on 16/8/4.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import "ViewController.h"
#import "ZYYRulerView.h"

@interface ViewController () <ZYYRulerViewDelegate>
@property (strong, nonatomic) UILabel *labelOne;
@property (strong, nonatomic) ZYYRulerView *rulerOne;
@property (strong, nonatomic) UILabel *labelTwo;
@property (strong, nonatomic) ZYYRulerView *rulerTwo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.labelOne];
    [self.view addSubview:self.rulerOne];
    [self.view addSubview:self.labelTwo];
    [self.view addSubview:self.rulerTwo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)zyy_rulerViewCurrentValue:(NSNumber *)value {
    NSLog(@"rulerTwo value = %@", value);
    self.labelTwo.text = [NSString stringWithFormat:@"%@", value];
}

- (NSString *)title {
    return NSStringFromClass([self class]);
}

- (UILabel *)labelOne {
    if (!_labelOne) {
        _labelOne = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 50)];
        _labelOne.textAlignment = NSTextAlignmentCenter;
        _labelOne.font = [UIFont systemFontOfSize:25];
    }
    return _labelOne;
}

- (ZYYRulerView *)rulerOne {
    if (!_rulerOne) {
        _rulerOne = [[ZYYRulerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.labelOne.frame), CGRectGetWidth(self.view.frame), 30)];
        _rulerOne.backgroundColor = [UIColor colorWithWhite:0.667 alpha:0.500];
        [_rulerOne updateCurrentValue:10];
        self.labelOne.text = [NSString stringWithFormat:@"%@", @(10)];
        [_rulerOne rulerViewCurrentValueWithBlock:^(NSNumber *value) {
            NSLog(@"rulerOne value = %@", value);
            self.labelOne.text = [NSString stringWithFormat:@"%@", value];
        }];
    }
    return _rulerOne;
}

- (UILabel *)labelTwo {
    if (!_labelTwo) {
        _labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.rulerOne.frame), CGRectGetWidth(self.view.frame), 50)];
        _labelTwo.textAlignment = NSTextAlignmentCenter;
        _labelTwo.font = [UIFont systemFontOfSize:25];
    }
    return _labelTwo;
}

- (ZYYRulerView *)rulerTwo {
    if (!_rulerTwo) {
        _rulerTwo = [[ZYYRulerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.labelTwo.frame), CGRectGetWidth(self.view.frame), 60)];
        _rulerTwo.backgroundColor = [UIColor colorWithWhite:0.667 alpha:0.500];
        _rulerTwo.rulerMinValue = 100;
        _rulerTwo.rulerMaxValue = 500;
        _rulerTwo.rulerSpacing = 10;
        _rulerTwo.rulerShortLineLength = 10;
        _rulerTwo.rulerMiddleLineLength = 20;
        _rulerTwo.rulerLongLineLength = 30;
        _rulerTwo.isShowHorizonalLine = YES;
        _rulerTwo.delegate = self;
        [_rulerTwo updateCurrentValue:200];
        self.labelTwo.text = [NSString stringWithFormat:@"%@", @(200)];
    }
    return _rulerTwo;
}

@end
