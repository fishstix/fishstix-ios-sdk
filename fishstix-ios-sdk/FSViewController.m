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

@end
