//
//  AddAlarmViewController.h
//  AlarmClock
//
//  Created by Jon Bauer on 4/16/13.
//  Copyright (c) 2013 Jon Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AlarmLabelEditViewController.h"


@interface AddEditAlarmViewController : UIViewController <AlarmLabelEditViewControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIDatePicker *timeToSetOff;
@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;
@property (nonatomic, assign) NSInteger indexOfAlarmToEdit;
@property(atomic,strong) NSString *label;
@property(nonatomic,assign) BOOL editMode;

@end
