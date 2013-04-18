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
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.label forKey:@"label"];
    [encoder encodeObject:self.timeToSetOff forKey:@"timeToSetOff"];
    [encoder encodeBool:self.enabled forKey:@"enabled"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self.label = [decoder decodeObjectForKey:@"label"];
    self.timeToSetOff = [decoder decodeObjectForKey:@"timeToSetOff"];
    self.enabled = [decoder decodeBoolForKey:@"enabled"];
    return self;
}

@end
