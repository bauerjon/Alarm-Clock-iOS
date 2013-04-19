//
//  AddAlarmViewController.h
//  AlarmClock
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
@property(nonatomic,assign) int notificationID;

@end
