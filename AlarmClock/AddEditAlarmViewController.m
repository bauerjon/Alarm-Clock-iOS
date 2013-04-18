//
//  AddAlarmViewController.m
//  AlarmClock
//
//  Created by Jon Bauer on 4/16/13.
//  Copyright (c) 2013 Jon Bauer. All rights reserved.
//

#import "AddEditAlarmViewController.h"
#import "AlarmListTableController.h"
#import "AlarmObject.h"


@interface AddEditAlarmViewController ()

@end

@implementation AddEditAlarmViewController

@synthesize tableView;
@synthesize timeToSetOff;
@synthesize label;
@synthesize navItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    if (self.editMode)
    {
        navItem.title = @"Edit Alarm";
        navItem.rightBarButtonItem.title = @"Save";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *alarmListData = [defaults objectForKey:@"AlarmListData"];
        NSMutableArray *alarmList = [NSKeyedUnarchiver unarchiveObjectWithData:alarmListData];
        AlarmObject * oldAlarmObject = [alarmList objectAtIndex:self.indexOfAlarmToEdit];
        self.label = oldAlarmObject.label;
        timeToSetOff.date = oldAlarmObject.timeToSetOff;  
        
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.editMode)
    {
        return 2;
    }
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    if(indexPath.section == 0)
    {
   
        // Set up the cell...
        UILabel *labelTextField = [[UILabel alloc] initWithFrame:CGRectMake(180, 4, 280, 35)];
        labelTextField.adjustsFontSizeToFitWidth = YES;
        labelTextField.textColor = [UIColor grayColor];
        labelTextField.backgroundColor = [UIColor clearColor];
        [labelTextField setEnabled: YES];       
        
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"Label";
            labelTextField.text = self.label;
        }
        
        
        [cell.contentView addSubview:labelTextField];
    }
    
    if(indexPath.section == 1)
    {
        cell.backgroundColor = [UIColor redColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"Delete this alarm";
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            
            AlarmLabelEditViewController *labelEditController = [mystoryboard instantiateViewControllerWithIdentifier:@"LabelEditView"];
            
            labelEditController.delegate = self;
            labelEditController.label = label;
            [self presentViewController:labelEditController animated:YES completion:nil];
        }        
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            UIAlertView *deleteAlarmAlert = [[UIAlertView alloc] initWithTitle:@"Delete Alarm"
                                                                  message:@"Are you sure you want to delete this alarm?"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Yes"
                                                        otherButtonTitles:@"Cancel", nil];
            [deleteAlarmAlert show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        //delete alarm
    }
    else{
        //do nothing
    }
}
-(IBAction)saveAlarm:(id)sender
{
    AlarmObject * newAlarmObject;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *alarmListData = [defaults objectForKey:@"AlarmListData"];
    NSMutableArray *alarmList = [NSKeyedUnarchiver unarchiveObjectWithData:alarmListData];
    
    if(!alarmList)
    {
        alarmList = [[NSMutableArray alloc]init];
    }
    
    if(self.editMode)//Editing Alarm that already exists
    {
        newAlarmObject = [alarmList objectAtIndex:self.indexOfAlarmToEdit];
        
    }
    else//Adding a new alarm
    {
        newAlarmObject = [[AlarmObject alloc]init];               
    }
    
    newAlarmObject.label = self.label;
    newAlarmObject.timeToSetOff = timeToSetOff.date;
    newAlarmObject.enabled = YES;
    
    
    if(self.editMode == NO){
    [alarmList addObject:newAlarmObject];
    }
    
    NSData *alarmListData2 = [NSKeyedArchiver archivedDataWithRootObject:alarmList];
    [[NSUserDefaults standardUserDefaults] setObject:alarmListData2 forKey:@"AlarmListData"];

    [self scheduleLocalNotificationWithDate:self.timeToSetOff.date];
    
    [self performSegueWithIdentifier: @"AlarmListSegue" sender: self];
}

- (void)scheduleLocalNotificationWithDate:(NSDate *)fireDate {    
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    if (!localNotification)
        return;
    
    // Current date
    //NSDate *date = [NSDate date];
    
    // Add one minute to the current time
    //NSDate *dateToFire = timeToSetOff.date;
    
    localNotification.repeatInterval = NSDayCalendarUnit;
    [localNotification setFireDate:timeToSetOff.date];
    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];  
    // Setup alert notification
    [localNotification setAlertBody:@"Alarm" ];
    [localNotification setAlertAction:@"Open App"];
    [localNotification setHasAction:YES];
    
    
    // Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

// Delegate Methods From Edit Views

- (void)updateLabelText:(NSString *)newLabel
{
    self.label = newLabel;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
