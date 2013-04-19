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
@synthesize notificationID;
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
    
    //Edit mode is only true when an existing alarm is pressed
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
        self.notificationID = oldAlarmObject.notificationID;
        
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.editMode)
    {
        return 2;//for the delete button
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

- (void)CancelExistingNotification
{
    //cancel alarm
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"notificationID"]];
        if ([uid isEqualToString:[NSString stringWithFormat:@"%i",self.notificationID]])
        {
            //Cancelling local notification
            
            [app cancelLocalNotification:oneEvent];
            break;
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        //cancel alarm
        [self CancelExistingNotification];
        //delete alarm
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *alarmListData = [defaults objectForKey:@"AlarmListData"];
        NSMutableArray *alarmList = [NSKeyedUnarchiver unarchiveObjectWithData:alarmListData];
        [alarmList removeObjectAtIndex: self.indexOfAlarmToEdit];
        NSData *alarmListData2 = [NSKeyedArchiver archivedDataWithRootObject:alarmList];
        [[NSUserDefaults standardUserDefaults] setObject:alarmListData2 forKey:@"AlarmListData"];
        
        
        
        [self performSegueWithIdentifier: @"AlarmListSegue" sender: self];
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
        
        [self CancelExistingNotification];
    }
    else//Adding a new alarm
    {
        newAlarmObject = [[AlarmObject alloc]init];
        newAlarmObject.enabled = YES;
        newAlarmObject.notificationID = [self getUniqueNotificationID];
    }
    
    newAlarmObject.label = self.label;
    newAlarmObject.timeToSetOff = timeToSetOff.date;
    newAlarmObject.enabled = YES;
    
    [self scheduleLocalNotificationWithDate:self.timeToSetOff.date atIndex:newAlarmObject.notificationID];
    
    if(self.editMode == NO){
        [alarmList addObject:newAlarmObject];
        
        
    }
    NSData *alarmListData2 = [NSKeyedArchiver archivedDataWithRootObject:alarmList];
    [[NSUserDefaults standardUserDefaults] setObject:alarmListData2 forKey:@"AlarmListData"];
    
   
    
    [self performSegueWithIdentifier: @"AlarmListSegue" sender: self];
}

- (void)scheduleLocalNotificationWithDate:(NSDate *)fireDate
                                  atIndex:(int)indexOfObject {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    
    if (!localNotification)
        return;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh-mm -a";
    NSDate* date = [dateFormatter dateFromString:[dateFormatter stringFromDate:timeToSetOff.date]];
    
    localNotification.repeatInterval = NSDayCalendarUnit;
    [localNotification setFireDate:date];
    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];  
    // Setup alert notification
    [localNotification setAlertBody:@"Alarm" ];
    [localNotification setAlertAction:@"Open App"];
    [localNotification setHasAction:YES];
    
    NSLog(@"%@", date);
    //This array maps the alarms uid to the index of the alarm so that we can cancel specific local notifications

    NSNumber* uidToStore = [NSNumber numberWithInt:indexOfObject];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:uidToStore forKey:@"notificationID"];
    localNotification.userInfo = userInfo;
    NSLog(@"Uid Store in userInfo %@", [localNotification.userInfo objectForKey:@"notificationID"]);
    
    // Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
}

//Get Unique Notification ID for a new alarm O(n)
-(int)getUniqueNotificationID
{
    NSMutableDictionary * hashDict = [[NSMutableDictionary alloc]init];
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSNumber *uid= [userInfoCurrent valueForKey:@"notificationID"];
        NSNumber * value =[NSNumber numberWithInt:1];       
        [hashDict setObject:value forKey:uid];
    }
    for (int i=0; i<[eventArray count]+1; i++)
    {
        NSNumber * value = [hashDict objectForKey:[NSNumber numberWithInt:i]];
        if(!value)
        {
            return i;
        }
    }
    return 0;
    
}

// Delegate Methods From Edit Views
// Add more delegates if you wish to add more feature edit views to the alarm
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
