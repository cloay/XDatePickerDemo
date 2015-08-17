//
//  ViewController.m
//  xdatepickerdemo
//
//  Created by cloay on 15/8/17.
//  Copyright (c) 2015年 cloay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *dateBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/6, self.view.frame.size.width/2, self.view.frame.size.width*2/3, self.view.frame.size.width/8)];
    [dateBtn setTitle:@"选择日期" forState:UIControlStateNormal];
    [dateBtn setTitle:@"选择日期" forState:UIControlStateHighlighted];
    [dateBtn setBackgroundColor:[UIColor redColor]];
    [dateBtn.layer setCornerRadius:4];
    [dateBtn.layer setMasksToBounds:YES];
    [dateBtn addTarget:self action:@selector(dateBtnDidTaped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dateBtn];
    
}

- (void)dateBtnDidTaped{
    //设置开始日期
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
    //设置截止日期
    NSDate *endDate = [NSDate dateWithTimeIntervalSinceNow:120*24*60*60];
    XDatePicker *picker = [[XDatePicker alloc] initWithTitle:@"请选择起止日期" startDate:startDate endDate:endDate];
    [picker setDelegate:self];
    [picker show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark XDatePicker delegate method
- (void)selectedStartDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    NSLog(@"startDate=%@, endDate=%@", startDate, endDate);
}
@end
