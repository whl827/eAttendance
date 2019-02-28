//
//  RegisteredClass.h
//  eAttendance
//
//  Created by Woonghee Lee on 12/2/17.
//  Copyright © 2017 Woonghee Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisteredClass : NSObject

//declare variables
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *location;
@property (nonatomic, readonly, copy) NSString *time;
@property (nonatomic, readonly, copy) NSString *days;

//constructor for creating a class
- (instancetype) initWithTitle: (NSString*) title
                      location: (NSString*) location
                          time: (NSString*) time
                          days: (NSString*) days;

@end
