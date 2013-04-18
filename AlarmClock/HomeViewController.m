//
//  ViewController.m
//  AlarmClock
//
//  Created by Jon Bauer on 3/27/13.
//  Copyright (c) 2013 Jon Bauer. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end


@implementation HomeViewController
@synthesize hour1Label;
@synthesize hour2Label;
@synthesize minute1Label;
@synthesize minute2Label;
@synthesize second1Label;
@synthesize second2Label;
@synthesize colon1;
@synthesize colon2;
@synthesize dhour1Label;
@synthesize dhour2Label;
@synthesize dminute1Label;
@synthesize dminute2Label;
@synthesize dsecond1Label;
@synthesize dsecond2Label;
@synthesize dcolon1;
@synthesize dcolon2;

@synthesize coverView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self myTimerAction];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(myTimerAction) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    //NSLog(@"%@", [UIFont familyNames]);
    
    colon1.font = [UIFont fontWithName:@"digital-7" size:90];
    colon2.font = [UIFont fontWithName:@"digital-7" size:90];
    hour1Label.font = [UIFont fontWithName:@"digital-7" size:90];
    minute1Label.font = [UIFont fontWithName:@"digital-7" size:90];
    second1Label.font = [UIFont fontWithName:@"digital-7" size:90];
    hour2Label.font = [UIFont fontWithName:@"digital-7" size:90];
    minute2Label.font = [UIFont fontWithName:@"digital-7" size:90];
    second2Label.font = [UIFont fontWithName:@"digital-7" size:90];
    
    dcolon1.font = [UIFont fontWithName:@"digital-7" size:90];
    dcolon2.font = [UIFont fontWithName:@"digital-7" size:90];
    dhour1Label.font = [UIFont fontWithName:@"digital-7" size:90];
    dminute1Label.font = [UIFont fontWithName:@"digital-7" size:90];
    dsecond1Label.font = [UIFont fontWithName:@"digital-7" size:90];
    dhour2Label.font = [UIFont fontWithName:@"digital-7" size:90];
    dminute2Label.font = [UIFont fontWithName:@"digital-7" size:90];
    dsecond2Label.font = [UIFont fontWithName:@"digital-7" size:90];
}


-(void)myTimerAction
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"hh:mm:ss a"];
    NSString *hourMinuteSecond = [dateFormatter stringFromDate:date];
//    if([[hourMinuteSecond substringWithRange:NSMakeRange(0, 1)]isEqual: @"0"])
//    {
//        hour1Label.text = @"";
//    }
    hour1Label.text = [hourMinuteSecond substringWithRange:NSMakeRange(0, 1)];
    hour2Label.text = [hourMinuteSecond substringWithRange:NSMakeRange(1, 1)];
    minute1Label.text = [hourMinuteSecond substringWithRange:NSMakeRange(3, 1)];
    minute2Label.text = [hourMinuteSecond substringWithRange:NSMakeRange(4, 1)];
    second1Label.text = [hourMinuteSecond substringWithRange:NSMakeRange(6, 1)];
    second2Label.text =[hourMinuteSecond substringWithRange:NSMakeRange(7, 1)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
