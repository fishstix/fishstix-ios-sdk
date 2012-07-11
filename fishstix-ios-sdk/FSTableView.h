//
//  FSTableView.h
//  Prayer
//
//  Created by Charles Fisher on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "FSTableHeaderSuperView.h"

@class FSTableView;
@class FSTableHeaderSuperView;

@protocol FSTableViewDelegate <UITableViewDelegate>
- (void) tableView:(FSTableView*)tableView superViewDidRelease:(FSTableHeaderSuperView*)superView;
@end

@interface FSTableViewHiddenDelegate : NSObject <UITableViewDelegate> {
    //@private
    //    UIDateTextField *_parent;
    id<UITableViewDelegate> _delegate;
}

//@property (nonatomic, retain) UIDateTextField *parent;
@property (nonatomic, retain) id<UITableViewDelegate> delegate;

@end

@interface FSTableView : UITableView
{
    BOOL _superVisible;
    int _headerSuperHeight;
    
    FSTableViewHiddenDelegate *_hiddenDelegate;
    id<FSTableViewDelegate> _superViewDelegate;
}

/**
 *  Hidden View, visible after scroll
 */
@property (nonatomic, strong) FSTableHeaderSuperView *tableHeaderSuperView;
@property (nonatomic, weak) id<FSTableViewDelegate> delegate;

@end

