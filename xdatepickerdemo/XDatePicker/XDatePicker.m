//
//  XDatePicker.m
//  yuepaiphotographer
//
//  Created by cloay on 15/7/27.
//  Copyright (c) 2015年 cloay. All rights reserved.
//

#import "XDatePicker.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBONLYCOLOR(x) RGBCOLOR(x,x,x)
#define RGBAONLYCOLOR(x,a) [UIColor colorWithRed:(x)/255.0 green:(x)/255.0 blue:(x)/255.0 alpha:(a)]

#define DEVICE_WIDTH [[UIScreen mainScreen] bounds].size.width
#define DEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height
//适配比例系数，简单适配
#define SCALE DEVICE_WIDTH/320


#define PICKER_WIDTH 265*SCALE
#define PICKER_HEIGHT 360*SCALE


@implementation XDatePicker

- (id)initWithTitle:(NSString *)title startDate:(NSDate *)startDate
            endDate:(NSDate *)endDate{
    
    if (self = [super init]) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12*SCALE, PICKER_WIDTH, 20*SCALE)];
        titleLabel.font = [UIFont boldSystemFontOfSize:20.0f*SCALE];
        [titleLabel setText:title];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        titleLabel.textColor = RGBCOLOR(226, 84, 54);
        [self addSubview:titleLabel];
        
        UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.frame.origin.y + 26*SCALE + 1, PICKER_WIDTH, 1*SCALE)];
        [lineLabel1 setBackgroundColor:RGBONLYCOLOR(224)];
        [self addSubview:lineLabel1];
        
        UILabel *startLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*SCALE, lineLabel1.frame.origin.y + 56*SCALE, 40*SCALE, 20*SCALE)];
        [startLabel setText:@"起始"];
        [startLabel setTextColor:RGBCOLOR(241, 115, 90)];
        [startLabel setFont:[UIFont systemFontOfSize:14*SCALE]];
        [self addSubview:startLabel];
        startDatePicker = [[UIDatePicker alloc] init];
        [startDatePicker setFrame:CGRectMake(50*SCALE, titleLabel.frame.origin.y + titleLabel.frame.size.height, PICKER_WIDTH - 40*SCALE, 40*SCALE)];
        [startDatePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        [startDatePicker setDatePickerMode:UIDatePickerModeDate];
        [startDatePicker setMinimumDate:startDate];
        [startDatePicker setMaximumDate:endDate];
        [startDatePicker setDate:startDate];
        [self addSubview:startDatePicker];
        
        UILabel *spaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, lineLabel1.frame.origin.y + 140*SCALE, PICKER_WIDTH, 1*SCALE)];
        [spaceLabel setBackgroundColor:RGBONLYCOLOR(224)];
        [self addSubview:spaceLabel];
        
        UILabel *endLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*SCALE, startLabel.frame.origin.y + 146*SCALE, 40*SCALE, 20*SCALE)];
        [endLabel setText:@"终止"];
        [endLabel setTextColor:RGBCOLOR(241, 115, 90)];
        [endLabel setFont:[UIFont systemFontOfSize:14*SCALE]];
        [self addSubview:endLabel];
        endDatePicker = [[UIDatePicker alloc] init];
        [endDatePicker setFrame:CGRectMake(50*SCALE, startDatePicker.frame.origin.y + 140*SCALE, PICKER_WIDTH - 40*SCALE, 40*SCALE)];
        [endDatePicker setDate:endDate];
        [endDatePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        [endDatePicker setDatePickerMode:UIDatePickerModeDate];
        [endDatePicker setMinimumDate:startDate];
        [endDatePicker setMaximumDate:endDate];
        [self addSubview:endDatePicker];
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, endLabel.frame.origin.y + 80*SCALE + 1, PICKER_WIDTH, 1*SCALE)];
        [lineLabel setBackgroundColor:RGBONLYCOLOR(224)];
        [self addSubview:lineLabel];
        
        leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, lineLabel.frame.origin.y + 1, PICKER_WIDTH/2, 40*SCALE);;
        rightBtn.frame = CGRectMake(PICKER_WIDTH/2, lineLabel.frame.origin.y + 1, PICKER_WIDTH/2, 40*SCALE);;
        
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        leftBtn.titleLabel.font = rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16*SCALE];
        [leftBtn setTitleColor:RGBONLYCOLOR(64) forState:UIControlStateNormal];
        [rightBtn setTitleColor:RGBONLYCOLOR(64) forState:UIControlStateNormal];
        
        [leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.layer.masksToBounds = rightBtn.layer.masksToBounds = YES;
        leftBtn.layer.cornerRadius = rightBtn.layer.cornerRadius = 3.0;
        
        
        UILabel *vLabel = [[UILabel alloc] initWithFrame:CGRectMake(PICKER_WIDTH/2, lineLabel.frame.origin.y, 1*SCALE, 45*SCALE)];
        [vLabel setBackgroundColor:RGBONLYCOLOR(224)];
        [self addSubview:vLabel];
        
        [self addSubview:leftBtn];
        [self addSubview:rightBtn];
        
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        [bgView setBackgroundColor:RGBAONLYCOLOR(0, 0.55)];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5*SCALE;
        self.layer.borderWidth = 1;
        self.layer.borderColor = RGBONLYCOLOR(224).CGColor;
        
    }
    
    return self;
}

- (void)leftBtnClicked:(id)sender
{
    [self dismissAlert];
}

- (void)rightBtnClicked:(id)sender
{
    [self dismissAlert];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedStartDate:endDate:)]) {
        [self.delegate selectedStartDate:startDatePicker.date endDate:endDatePicker.date];
    }
}

- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - PICKER_WIDTH) * 0.5, - PICKER_HEIGHT - 30*SCALE, PICKER_WIDTH, PICKER_HEIGHT);
    [topVC.view addSubview:bgView];
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    [bgView removeFromSuperview];
    [self removeFromSuperview];
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperview
{
    UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - PICKER_WIDTH) * 0.5, CGRectGetHeight(topVC.view.bounds), PICKER_WIDTH, PICKER_HEIGHT);
    
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - PICKER_WIDTH) * 0.5, (CGRectGetHeight(topVC.view.bounds) - PICKER_HEIGHT) * 0.5, PICKER_WIDTH, PICKER_HEIGHT);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}

@end
