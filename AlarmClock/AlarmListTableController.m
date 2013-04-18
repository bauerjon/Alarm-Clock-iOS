//
//  EasyCustomTableController.m
//  EasyCustomTable
//
//  Created by Matt Gallagher on 27/04/09.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "AlarmListTableController.h"
#import "AlarmObject.h"
#import "AddEditAlarmViewController.h"

#define USE_CUSTOM_DRAWING 1

@implementation AlarmListTableController

@synthesize tableView;
@synthesize imageView;
@synthesize listOfAlarms;
#if USE_CUSTOM_DRAWING

//
// viewDidLoad
//
// Configures the table after it is loaded.
//
- (void)viewDidLoad
{
	//
	// Change the properties of the imageView and tableView (these could be set
	// in interface builder instead).
	//
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableView.rowHeight = 70;
	tableView.backgroundColor = [UIColor clearColor];
	imageView.image = [UIImage imageNamed:@"gradientBackground.png"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *alarmListData = [defaults objectForKey:@"AlarmListData"];
    self.listOfAlarms = [NSKeyedUnarchiver unarchiveObjectWithData:alarmListData];


}

#endif

//
// numberOfSectionsInTableView:
//
// Return the number of sections for the table.
//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

//
// tableView:numberOfRowsInSection:
//
// Returns the number of rows in a given section.
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.listOfAlarms){
        
        return [self.listOfAlarms count];
    }
    else return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"AlarmListToEditAlarm" sender:self];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"AlarmListToEditAlarm"]){
        AddEditAlarmViewController *controller = (AddEditAlarmViewController *)segue.destinationViewController;
        controller.indexOfAlarmToEdit = tableView.indexPathForSelectedRow.row;
        controller.editMode = YES;
    }
}
//
// tableView:cellForRowAtIndexPath:
//
// Returns the cell for a given indexPath.
//
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateFormatter * dateReader = [[NSDateFormatter alloc] init];
    [dateReader setDateFormat:@"hh:mm a"];
    AlarmObject *currentAlarm = [self.listOfAlarms objectAtIndex:indexPath.row];
    
    NSString *label = currentAlarm.label;
    BOOL enabled = currentAlarm.enabled;
    NSString *date = [dateReader stringFromDate:currentAlarm.timeToSetOff];
    
    
	UILabel *topLabel;
	UILabel *bottomLabel;
    UISwitch *enabledSwitch;

	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		//
		// Create the cell.
		//
		cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];

        //incase we want to add an image to the cells
//		UIImage *indicatorImage = [UIImage imageNamed:@"indicator.png"];
//		cell.accessoryView =
//			[[[UIImageView alloc]
//				initWithImage:indicatorImage]
//			autorelease];

		//
		// Create the label for the top row of text
		//
		topLabel =
			[[UILabel alloc]
				initWithFrame:
              CGRectMake(14,5,170,40)];
		[cell.contentView addSubview:topLabel];

		//
		// Configure the properties for the text that are the same on every row
		//
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor blackColor];
		topLabel.highlightedTextColor = [UIColor whiteColor];
		topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]+2];

		//
		// Create the label for the top row of text
		//
		bottomLabel =
			[[UILabel alloc]
				initWithFrame:
					CGRectMake(14,30,170,40)];
		[cell.contentView addSubview:bottomLabel];

		//
		// Configure the properties for the text that are the same on every row
		//
		bottomLabel.backgroundColor = [UIColor clearColor];
		bottomLabel.textColor = [UIColor blackColor];
		bottomLabel.highlightedTextColor = [UIColor whiteColor];
		bottomLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];

        
        enabledSwitch = [[UISwitch alloc]
                         initWithFrame:
                         CGRectMake(200,20,170,40)];
		[cell.contentView addSubview:enabledSwitch];
        
        [enabledSwitch setOn:enabled];
        topLabel.text = date;
        bottomLabel.text = label;

	}
	
	return cell;
}

//
// dealloc
//
// Releases instance memory.
//


@end


