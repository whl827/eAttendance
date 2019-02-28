//
//  ViewController.m
//  eAttendance
//
//  Created by Woonghee on 12/2/17.
//  Copyright © 2017 Woonghee Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//    Create a private property for the model.
@property (strong, nonatomic) RegisteredClassModel *dataModel;
@property (weak, nonatomic) IBOutlet UILabel *ClassLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //In the viewDidLoad method, create the model by calling the sharedModel method.
    self.dataModel = [RegisteredClassModel sharedModel];
    
    RegisteredClass* class = [self.dataModel classAtIndex:0];
    [_ClassLabel setText:[class title]];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnce:)];
    [self.view addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedTwice:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    //    Handle swiping left and right.
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:swipeRight];
    
}

-(void) viewWillAppear:(BOOL)animated{
    
    if([self.dataModel numberOfRegisteredClass]==0){
        [_ClassLabel setText:@"There Are No Registered Classes"];
    }else{
        int current_index = [self.dataModel currentIndex];
        RegisteredClass* class = [self.dataModel classAtIndex:current_index];
        [_ClassLabel setText:[class title]];
    }
}

- (void) fadeOut {
    // alpha is a property on the UILabel
    // It is the transparency value
    // if = 0, full transparency so don't see text
    // if = 1,
    self.ClassLabel.alpha = 0.0;
}

- (void) fadeIn: (NSString *) newMessage
      withColor: (UIColor *) newColor {
    
    self.ClassLabel.text = newMessage;
    self.ClassLabel.textColor = newColor;
    
    [UIView animateWithDuration:2.0 animations:^{
        self.ClassLabel.alpha = 1.0;
    }];
}

//    – Use Gesture Recognizers to display a next class if the view is tapped once
- (void) tappedOnce: (UITapGestureRecognizer *) recognizer {
    
    RegisteredClass* class = NULL;
    if([self.dataModel numberOfRegisteredClass]==0){
        [UIView animateWithDuration:0.5 animations: ^{
            [self fadeOut];
        }
                         completion:^(BOOL finished) {
                             [_ClassLabel setText:@"There Are No Registered Classes"];
                             [self fadeIn: _ClassLabel.text
                                withColor: UIColor.blackColor];
                         }];
        
    }else{
        
        class = [self.dataModel nextClass];
        
        
        [UIView animateWithDuration:0.5 animations: ^{
            [self fadeOut];
        }
                         completion:^(BOOL finished) {
                             [_ClassLabel setText:[class title]];
                             [self fadeIn: _ClassLabel.text
                                withColor: UIColor.blackColor];
                         }];
    }
}

//    Display the answer when the view is double tapped.
- (void) tappedTwice: (UITapGestureRecognizer *) recognizer {
    
    RegisteredClass* class = NULL;
    
    if([self.dataModel numberOfRegisteredClass]==0){
        [UIView animateWithDuration:0.5 animations: ^{
            [self fadeOut];
        }
                         completion:^(BOOL finished) {
                             [_ClassLabel setText:@"Please register classes"];
                             [self fadeIn: _ClassLabel.text
                                withColor: UIColor.blackColor];
                         }];
    }else{
        
        class = [self.dataModel classAtIndex:[self.dataModel currentIndex]];
        
        [UIView animateWithDuration:0.5 animations: ^{
            [self fadeOut];
        }
                         completion:^(BOOL finished) {
                             NSString* classInfo = [NSString stringWithFormat: @"Course Title: %@ \n\nLocation: %@ \n\nTime: %@ \n\nDay: %@", [class title], [class location], [class time], [class days]];
//                                                [class title], [class location], [class time], [class days]];
                             
                             [_ClassLabel setText:classInfo];
                             [self fadeIn: _ClassLabel.text
                                withColor: UIColor.blackColor];
                         }];
    }
}

//    display previous question
- (void) swipeRight: (UISwipeGestureRecognizer *) recognizer {
    
    RegisteredClass* class = NULL;
    if([self.dataModel numberOfRegisteredClass]==0){
        [UIView animateWithDuration:0.5 animations: ^{
            [self fadeOut];
        }
                         completion:^(BOOL finished) {
                             [_ClassLabel setText:@"There Are No Registered Classes"];
                             [self fadeIn: _ClassLabel.text
                                withColor: UIColor.blackColor];
                         }];
        
    }else{
        
        class = [self.dataModel prevClass];
        
        [UIView animateWithDuration:0.5 animations: ^{
            [self fadeOut];
        }
                         completion:^(BOOL finished) {
                             [_ClassLabel setText:[class title]];
                             [self fadeIn: _ClassLabel.text
                                withColor: UIColor.blackColor];
                         }];
    }
    
}

//    Display next question
- (void) swipeLeft: (UISwipeGestureRecognizer *) recognizer {
    
    RegisteredClass* class = NULL;
    if([self.dataModel numberOfRegisteredClass]==0){
        [UIView animateWithDuration:0.5 animations: ^{
            [self fadeOut];
        }
                         completion:^(BOOL finished) {
                             [_ClassLabel setText:@"There Are No Registered Classes"];
                             [self fadeIn: _ClassLabel.text
                                withColor: UIColor.blackColor];
                         }];
        
    }else{
        
        class = [self.dataModel nextClass];
        
        [UIView animateWithDuration:0.5 animations: ^{
            [self fadeOut];
        }
                         completion:^(BOOL finished) {
                             [_ClassLabel setText:[class title]];
                             [self fadeIn: _ClassLabel.text
                                withColor: UIColor.blackColor];
                         }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
