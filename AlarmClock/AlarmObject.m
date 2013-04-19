//
//  AlarmObject.m
//  AlarmClock
//
//  Created by Jon Bauer on 4/16/13.
//  Copyright (c) 2013 Jon Bauer. All rights reserved.
//

#import "AlarmObject.h"

@implementation AlarmObject

@synthesize label;
@synthesize timeToSetOff;
@synthesize enabled;
@synthesize notificationID;

//This is important to for saving the alarm object in user defaults
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.label forKey:@"label"];
    [encoder encodeObject:self.timeToSetOff forKey:@"timeToSetOff"];
    [encoder encodeBool:self.enabled forKey:@"enabled"];
    [encoder encodeInt:self.notificationID forKey:@"notificationID"];
}
//This is important to for loading the alarm object from user defaults
-(id)initWithCoder:(NSCoder *)decoder
{
    self.label = [decoder decodeObjectForKey:@"label"];
    self.timeToSetOff = [decoder decodeObjectForKey:@"timeToSetOff"];
    self.enabled = [decoder decodeBoolForKey:@"enabled"];
    self.notificationID = [decoder decodeIntForKey:@"notificationID"];
    return self;
}

@end
