//
//  ViewController.h
//  AlarmClock
//
//  Created by Jon Bauer on 3/27/13.
//  Copyright (c) 2013 Jon Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property(strong, nonatomic) IBOutlet UILabel * hour1Label;
@property(strong, nonatomic) IBOutlet UILabel * hour2Label;
@property(strong, nonatomic) IBOutlet UILabel * minute1Label;
@property(strong, nonatomic) IBOutlet UILabel * minute2Label;
@property(strong, nonatomic) IBOutlet UILabel * second1Label;
@property(strong, nonatomic) IBOutlet UILabel * second2Label;
@property(strong, nonatomic) IBOutlet UILabel * colon1;
@property(strong, nonatomic) IBOutlet UILabel * colon2;

@property(strong, nonatomic) IBOutlet UILabel * dhour1Label;
@property(strong, nonatomic) IBOutlet UILabel * dhour2Label;
@property(strong, nonatomic) IBOutlet UILabel * dminute1Label;
@property(strong, nonatomic) IBOutlet UILabel * dminute2Label;
@property(strong, nonatomic) IBOutlet UILabel * dsecond1Label;
@property(strong, nonatomic) IBOutlet UILabel * dsecond2Label;
@property(strong, nonatomic) IBOutlet UILabel * dcolon1;
@property(strong, nonatomic) IBOutlet UILabel * dcolon2;
@property(strong, nonatomic) IBOutlet UIView * coverView;


@end
