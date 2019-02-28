//
//  RegisteredClassModel.m
//  eAttendance
//
//  Created by Woonghee Lee on 12/2/17.
//  Copyright © 2017 Woonghee Lee. All rights reserved.
//

#import "RegisteredClassModel.h"


static NSString *const kClassesPList = @"ClassesList.plist";

@interface RegisteredClassModel()

//declare private properties

@property (strong, nonatomic) NSString *filepath;

@property (nonatomic, strong) NSMutableArray* registeredClasses;

@end

@implementation RegisteredClassModel


//save to file path
-(void) save{
    
    //dictionary for each values of each class
    NSMutableDictionary *titleDict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *locationDict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *timeDict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *daysDict = [[NSMutableDictionary alloc] init];
    
    //store from model to dictionaries
    for(int i=0; i<[_registeredClasses count]; i++){
        RegisteredClass *class = self.registeredClasses[i];
        NSString *cur_title = class.title;
        NSString *cur_location = class.location;
        NSString *cur_time = class.time;
        NSString *cur_days = class.days;
        
        NSString* keyInStr = [NSString stringWithFormat:@"%i", i];
        
        [titleDict setObject:cur_title forKey: keyInStr];
        [locationDict setObject:cur_location forKey: keyInStr];
        [timeDict setObject:cur_time forKey: keyInStr];
        [daysDict setObject:cur_days forKey: keyInStr];
    }
    
    //output to plist
    NSMutableDictionary *output = [[NSMutableDictionary alloc] init];
    
    [output setObject:titleDict forKey:kTitlekey];
    [output setObject:locationDict forKey:kLocationKey];
    [output setObject:timeDict forKey:kTimeKey];
    [output setObject:daysDict forKey:kDaysKey];
    
    [output writeToFile:_filepath atomically:YES];
    
    NSLog(@"\n\nFILE PATH FROM SAVE: %@", _filepath);
    
}

-(instancetype)init{
    self = [super init];
    if(self){
        
        //initalize path
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        _filepath = [documentsDirectory stringByAppendingPathComponent: kClassesPList];
        NSMutableDictionary *incomingDictionary = incomingDictionary = [NSMutableDictionary dictionaryWithContentsOfFile: _filepath];
        
        if(!incomingDictionary || [incomingDictionary[kTitlekey] count] == 0){
            
            NSLog(@"THERE IS NO FILE");
            
            // initialize sample classes
            RegisteredClass* class1 = [[RegisteredClass alloc] initWithTitle:@"CSCI 103" location:@"Viterbi SAL 101" time:@"10:30PM to 11:30 PM" days:@"M W"];
            RegisteredClass* class2 = [[RegisteredClass alloc] initWithTitle:@"MUIN 270" location:@"Thorton KDC240" time:@"10:30PM to 11:30 PM" days:@"T TH"];
            RegisteredClass* class3 = [[RegisteredClass alloc] initWithTitle:@"ASCJ 200" location:@"Annenberg ANN 309" time:@"10:30PM to 11:30 PM" days:@"F"];
            RegisteredClass* class4 = [[RegisteredClass alloc] initWithTitle:@"ACAD 174" location:@"Art SKS 404" time:@"10:30PM to 11:30 PM" days:@"M W"];
            RegisteredClass* class5 = [[RegisteredClass alloc] initWithTitle:@"ACCT 370" location:@"Marshall ACC 201" time:@"10:30PM to 11:30 PM" days:@"T TH"];
            
            //initialize class array
            _registeredClasses = [NSMutableArray arrayWithObjects:class1,class2,class3,class4,class5, nil];
            
            //initalize currentindex
            _currentIndex = 0;
            
        }else{
            
            //FILE EXISTS: move to model
            NSMutableDictionary *titleDict = incomingDictionary[kTitlekey];
            NSMutableDictionary *locationDict = incomingDictionary[kLocationKey];
            NSMutableDictionary *timeDict = incomingDictionary[kTimeKey];
            NSMutableDictionary *daysDict = incomingDictionary[kDaysKey];
            
            _registeredClasses = [[NSMutableArray alloc] init];
            
            for(int i=0; i<[titleDict count]; i++){
                
                NSString* keyInStr = [NSString stringWithFormat:@"%i", i];
                
                NSString *title = titleDict[keyInStr];
                NSString *location = locationDict[keyInStr];
                NSString *time = timeDict[keyInStr];
                NSString *days = daysDict[keyInStr];
                
                RegisteredClass* class = [[RegisteredClass alloc] initWithTitle:title location:location time:time days:days];
                
                [self.registeredClasses addObject: class];
            }
        }
    }
    return self;
}

//singleton
+ (instancetype) sharedModel {
    
    static RegisteredClassModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModel = [[self alloc] init];
        
    });
    
    return _sharedModel;
}

// Accessing number of classes
- (NSUInteger) numberOfRegisteredClass{
    return [self.registeredClasses count];
}

// Accessing a flashcard
- (RegisteredClass *) classAtIndex: (NSUInteger) index{
    
    if(index < [self.registeredClasses count]){
        return self.registeredClasses[index];
    }
    return nil;
    
}

// Access next class
- (RegisteredClass *) nextClass{
    //if greater than size -1, go back to 0,
    //if not, increment
    if(_currentIndex == ([self.registeredClasses count] - 1)){
        _currentIndex = 0;
    }else{
        _currentIndex++;
    }
    return self.registeredClasses[_currentIndex];
}

//Access prev class
- (RegisteredClass *) prevClass{
    if(_currentIndex == 0){
        _currentIndex = (int)[self.registeredClasses count] - 1;
    }else{
        _currentIndex--;
    }
    return self.registeredClasses[_currentIndex];
}

// Inserting a class
- (void) insertWithTitle: (NSString *) title
                location: (NSString *) location
                    time: (NSString*) time
                     day: (NSString*) days{
    
    RegisteredClass* newClass = [[RegisteredClass alloc] initWithTitle:title location:location time:time days:days];
    
    [self.registeredClasses addObject: newClass];
    [self save];
}

// Removing a flashcard
- (void) removeClass{
    
    //check empty
    if([self.registeredClasses count] != 0){
        //remove and check if current index is out of bounds
        [_registeredClasses removeLastObject];
        if(_currentIndex >= [self.registeredClasses count]){
            _currentIndex = 0;
        }
        [self save];
    }
}

- (void) removeClassAtIndex: (NSUInteger) index{
    //check empty
    if([self.registeredClasses count] != 0){
        //check if index is in bound
        if(index < [self.registeredClasses count]){
            [_registeredClasses removeObjectAtIndex: index];
            //if current index is out of bound, set it to 0
            if(_currentIndex >= [self.registeredClasses count]){
                _currentIndex = 0;
            }
        }
        [self save];
    }
}

@end
