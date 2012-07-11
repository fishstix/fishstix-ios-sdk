//
//  FSTableHeaderSuperView.h
//  Prayer
//
//  Created by Charles Fisher on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FSTableView.h"

@interface FSTableHeaderSuperView : UIView
{
    BOOL _visible;
    id<FSTableViewDelegate> _delegate;
}

@property (nonatomic, strong) id<FSTableViewDelegate> delegate;

- (void) superViewIsVisible;
- (void) superViewIsNotVisible;
- (void) tableViewIsReleased;

// For Subclass
- (void) updateUI:(BOOL)visible;
- (void) superViewRun;

@end
