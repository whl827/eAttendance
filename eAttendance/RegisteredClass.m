//
//  RegisteredClass.m
//  eAttendance
//
//  Created by Woonghee Lee on 12/2/17.
//  Copyright © 2017 Woonghee Lee. All rights reserved.
//

#import "RegisteredClass.h"

@implementation RegisteredClass

//method for creating a class
- (instancetype) initWithTitle: (NSString*) title
                      location: (NSString*) location
                          time: (NSString*) time
                          days: (NSString*) days {
    
    self = [super init];
    if (self) {
        _title = title;
        _location = location;
        _time = time;
        _days = days;
    }
    return self;
    
}

@end
