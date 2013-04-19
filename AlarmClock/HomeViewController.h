//
//  ViewController.h
//  AlarmClock
//


#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UIAlertViewDelegate>

@property(strong, nonatomic) IBOutlet UILabel * hour1Label;
@property(strong, nonatomic) IBOutlet UILabel * hour2Label;
@property(strong, nonatomic) IBOutlet UILabel * minute1Label;
@property(strong, nonatomic) IBOutlet UILabel * minute2Label;
@property(strong, nonatomic) IBOutlet UILabel * colon1;
@property(nonatomic) BOOL alarmGoingOff;


@end
