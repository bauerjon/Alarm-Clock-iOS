//
//  ViewController.m
//  AlarmClock
//
//  Created by Jon Bauer on 3/27/13.
//  Copyright (c) 2013 Jon Bauer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController
@synthesize timeLabel;
@synthesize coverView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(myTimerAction) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    //NSLog(@"%@", [UIFont familyNames]);

    timeLabel.font = [UIFont fontWithName:@"digital-7" size:56];
}


-(void)myTimerAction
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss a"];
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    timeLabel.text = formattedDateString;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
