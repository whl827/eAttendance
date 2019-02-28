//
//  RegisteredClassModel.h
//  eAttendance
//
//  Created by Woonghee Lee on 12/2/17.
//  Copyright © 2017 Woonghee Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisteredClass.h"

//constants for dictionary key
static NSString* const kTitlekey = @"title";
static NSString* const kLocationKey = @"location";
static NSString* const kTimeKey = @"time";
static NSString* const kDaysKey = @"days";

@interface RegisteredClassModel : NSObject

@property (nonatomic, readonly) unsigned int currentIndex;

// Creating the model
+ (instancetype) sharedModel;

// Accessing number of classes
- (NSUInteger) numberOfRegisteredClass;

// Accessing a class
- (RegisteredClass *) classAtIndex: (NSUInteger) index;
- (RegisteredClass *) nextClass;
- (RegisteredClass *) prevClass;

// Inserting a class
- (void) insertWithTitle: (NSString *) title
                location: (NSString *) location
                    time: (NSString*) time
                     day: (NSString*) days;

// Removing a class
- (void) removeClass;
- (void) removeClassAtIndex: (NSUInteger) index;

@end
