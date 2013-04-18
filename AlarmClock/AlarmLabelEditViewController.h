//
//  AlarmLabelEditViewController.h
//  AlarmClock
//
//  Created by Jon Bauer on 4/16/13.
//  Copyright (c) 2013 Jon Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmLabelEditViewController;

@protocol AlarmLabelEditViewControllerDelegate <NSObject>
- (void)updateLabelText:(NSString*)newLabel;
@end

@interface AlarmLabelEditViewController : UIViewController<UITextFieldDelegate>{
    UITextField * labelField;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString * label;
@property(unsafe_unretained) id <AlarmLabelEditViewControllerDelegate> delegate;

@end
