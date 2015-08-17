//
//  XDatePicker.h
//  yuepaiphotographer
//
//  Created by cloay on 15/7/27.
//  Copyright (c) 2015年 cloay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XDatePickerDelegate;

@interface XDatePicker : UIView{
    UIDatePicker *startDatePicker;
    UIDatePicker *endDatePicker;
    UIButton *leftBtn;
    UIButton *rightBtn;
    
    UIView *bgView;
}

/**
 *  初始化
 *
 *  @param title     标题
 *  @param startDate 起始日期
 *  @param endDate   结束日期
 *
 *  @return datePicker
 */
- (id)initWithTitle:(NSString *)title startDate:(NSDate *)startDate
            endDate:(NSDate *)endDate;

/**
 *  show
 */
- (void)show;

@property (nonatomic, assign) id<XDatePickerDelegate> delegate;

@end

@protocol XDatePickerDelegate <NSObject>

- (void)selectedStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
