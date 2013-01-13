//
//  FSViewController.m
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 9/2/12.
//
//

#import "FSViewController.h"

@interface FSViewController ()

@end

@implementation FSViewController

#pragma mark -
#pragma mark INIT

- (id) init
{
    NSString *filename = NSStringFromClass([self class]);
    
    if ([[NSBundle mainBundle] pathForResource:filename ofType:@"nib"] != nil)  {
        self = [self initWithNibName:filename bundle:nil];
    } else {
        self = [super init];
    }
    
    if (self) {
        //
    }
    
    return self;
}

#pragma mark -
#pragma mark VIEW LIFECYCLE

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark -
#pragma mark KEYBOARD

- (void) keyboardDidShow:(id)notification
{
    DLog(@"Class: %@", NSStringFromClass([self class]));
    DLog(@"Keyboard Shown");
    DLog(@"Notification: %@", notification);
    
    UIView *responder = [self findFirstResponder:self.view];
    DLog(@"View: %@", responder);
}

- (void) keyboardDidHide:(id)notification
{
    DLog(@"Keyboard Hide");
}

- (UIView*) findFirstResponder:(UIView*)view
{
    return [self findFirstResponderHelper:view];
}

- (UIView*) findFirstResponderHelper:(UIView*) view
{
    for (UIView *subview in view.subviews) {
        if ([subview isFirstResponder]) {
            return subview;
        }
        
        UIView *subviewResponder = [self findFirstResponderHelper:subview];
        if (subviewResponder) {
            return subviewResponder;
        }
    }
    
    return nil;
}

@end
