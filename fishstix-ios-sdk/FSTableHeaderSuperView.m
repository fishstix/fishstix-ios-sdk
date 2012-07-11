//
//  FSTableHeaderSuperView.m
//  Prayer
//
//  Created by Charles Fisher on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FSTableHeaderSuperView.h"

@interface FSTableHeaderSuperView()
@property (nonatomic, assign) BOOL visible;
@end

@implementation FSTableHeaderSuperView
@synthesize visible = _visible;
@synthesize delegate = _delegate;

- (void) superViewIsVisible
{
    self.visible = YES;
    
    [self updateUI: self.visible];
}

- (void) superViewIsNotVisible
{
    self.visible = NO;
    
    [self updateUI: self.visible];
}

- (void) tableViewIsReleased
{
    if (self.visible) {
        [self superViewRun];
    }
}

- (void) updateUI:(BOOL)visible
{
    DLog(@"UPDATE THAT UI DUDE!!!");
}

- (void) superViewRun
{
    [self.delegate tableView:nil superViewDidRelease:self];
    DLog(@"Super View Logic - TODO");
}

@end
