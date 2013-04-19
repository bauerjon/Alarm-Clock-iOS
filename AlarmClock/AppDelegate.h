//
//  AppDelegate.h
//  AlarmClock
//
//  Created by Jon Bauer on 3/27/13.
//  Copyright (c) 2013 Jon Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) AVAudioPlayer *player;
@end
