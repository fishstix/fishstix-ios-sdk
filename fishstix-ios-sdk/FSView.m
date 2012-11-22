//
//  AppView.m
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "FSView.h"

@implementation FSView

- (id) initWithFrame:(CGRect)frame
{
    NSString *filename = NSStringFromClass([self class]);
    
    if ([[NSBundle mainBundle] pathForResource:filename ofType:@"nib"] != nil)  {
        self = [UIView initWithNibName:filename withSelf:self];
    } else {
        self = [super initWithFrame:frame];
    }

    if (self) {
        // Initialization code.
    }
    return self;
}

- (void) viewDidAppear
{
    
}

- (void) viewDidDisappear
{
    
}

@end
