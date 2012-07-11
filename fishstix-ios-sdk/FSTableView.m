//
//  FSTableView.m
//  Prayer
//
//  Created by Charles Fisher on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FSTableView.h"

#import "FSTableHeaderSuperView.h"

@interface FSTableView()// <UIScrollViewDelegate>
@property (nonatomic, assign) BOOL superVisible;
@property (nonatomic, assign) int headerSuperHeight;
@property (nonatomic, strong) FSTableViewHiddenDelegate *hiddenDelegate;
@end

@implementation FSTableViewHiddenDelegate

//@synthesize parent = _parent;
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Table Delegate Methods

// Begin
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(textFieldShouldBeginEditing::)]) {
        return [_delegate textFieldShouldBeginEditing:(UITextField*)self.parent];
    }
    return YES;
}

- (CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath {
    if ([_delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [_delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 0;
}

- (NSIndexPath*) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"WILL SELECT");
    return indexPath;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"HEY DUDER");
}

//– tableView:indentationLevelForRowAtIndexPath:
//– tableView:willDisplayCell:forRowAtIndexPath:
//Managing Accessory Views
//– tableView:accessoryButtonTappedForRowWithIndexPath:
//– tableView:accessoryTypeForRowWithIndexPath: Deprecated in iOS 3.0
//Managing Selections
//– tableView:willSelectRowAtIndexPath:
//– tableView:didSelectRowAtIndexPath:
//– tableView:willDeselectRowAtIndexPath:
//– tableView:didDeselectRowAtIndexPath:
//Modifying the Header and Footer of Sections
//– tableView:viewForHeaderInSection:
//– tableView:viewForFooterInSection:
//– tableView:heightForHeaderInSection:
//– tableView:heightForFooterInSection:
//Editing Table Rows
//– tableView:willBeginEditingRowAtIndexPath:
//– tableView:didEndEditingRowAtIndexPath:
//– tableView:editingStyleForRowAtIndexPath:
//– tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:
//– tableView:shouldIndentWhileEditingRowAtIndexPath:
//Reordering Table Rows
//– tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:
//Copying and Pasting Row Content
//– tableView:shouldShowMenuForRowAtIndexPath:
//– tableView:canPerformAction:forRowAtIndexPath:withSender:
//– tableView:performAction:forRowAtIndexPath:withSender:

#pragma mark -
#pragma mark Scroll Delegate Methods

- (void) scrollViewDidScroll:(UIScrollView *)scrollView 
{
    FSTableView *tableView = (FSTableView*) scrollView;
    
    if ((tableView.contentOffset.y * -1) >= tableView.headerSuperHeight) {
        if (!tableView.superVisible) {
            tableView.superVisible = YES;
            [tableView.tableHeaderSuperView superViewIsVisible];
        }
    } else {
        if (tableView.superVisible) {
            tableView.superVisible = NO;
            [tableView.tableHeaderSuperView superViewIsNotVisible];
        }
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    FSTableView *tableView = (FSTableView*) scrollView;
    [tableView.tableHeaderSuperView tableViewIsReleased];
}

@end

@implementation FSTableView

@synthesize superVisible = _superVisible;
@synthesize headerSuperHeight = _headerSuperHeight;
@dynamic tableHeaderSuperView;
//@dynamic delegate;
@synthesize hiddenDelegate = _hiddenDelegate;
//@synthesize delegate = _superViewDelegate;
@synthesize delegate = _delegate;

- (void) setDelegate:(id<FSTableViewDelegate>)delegate
{
//    _superViewDelegate = delegate;
    [super setDelegate:delegate];
}


#define kHeaderFishViewTag 45631
#define kHeaderSuperViewTag 45632

#pragma mark -
#pragma mark init

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Add Fish Symbol
        UILabel *fishSymbol = [[UILabel alloc] initWithFrame:CGRectMake(0, -100, 300, 30)];
        [fishSymbol setText:@"<><"];
        [fishSymbol setBackgroundColor:[UIColor clearColor]];
        [fishSymbol setTextAlignment:UITextAlignmentCenter];
        [self addSubview:fishSymbol];
     
        FSTableViewHiddenDelegate *hiddenDelegate = [[FSTableViewHiddenDelegate alloc] init];
//        [self setHiddenDelegate:hiddenDelegate];
        [self setDelegate:hiddenDelegate];
//        [super setDelegate:(id<UITableViewDelegate>) self];
    }
    
    return self;
}

#pragma mark -
#pragma mark SuperView

- (void) setTableHeaderSuperView:(FSTableHeaderSuperView *)tableHeaderSuperView
{
    // Hidden
    [tableHeaderSuperView setFrame:CGRectMake(0, - tableHeaderSuperView.frame.size.height, tableHeaderSuperView.frame.size.width, tableHeaderSuperView.frame.size.height)];
    // Tagged
    [tableHeaderSuperView setTag:kHeaderSuperViewTag];
    
    // Existing?
    if ([self viewWithTag:kHeaderSuperViewTag]) {
        [[self viewWithTag:kHeaderSuperViewTag] removeFromSuperview];
    }
    
    [self addSubview:tableHeaderSuperView];
    
    self.superVisible = NO;
    self.headerSuperHeight = tableHeaderSuperView.frame.size.height;
    
//    if (self.delegate) {
//        self.headerSuperHeight.de
//    }
}

- (FSTableHeaderSuperView*) tableHeaderSuperView
{
    return (FSTableHeaderSuperView*)[self viewWithTag:kHeaderSuperViewTag];
}

#pragma mark -
#pragma mark TableViewDelegate

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"BLAH BLAH");
    
    if ([_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

//- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

#pragma mark -
#pragma mark ScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView 
{
    if ((scrollView.contentOffset.y * -1) >= self.headerSuperHeight) {
        if (!self.superVisible) {
            self.superVisible = YES;
            [self.tableHeaderSuperView superViewIsVisible];
        }
    } else {
        if (self.superVisible) {
            self.superVisible = NO;
            [self.tableHeaderSuperView superViewIsNotVisible];
        }
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.tableHeaderSuperView tableViewIsReleased];
}

@end
