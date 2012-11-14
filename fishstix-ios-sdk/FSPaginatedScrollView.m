//
//  FSPaginatedScrollView.m
//  Prayer
//
//  Created by Charles Fisher on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FSPaginatedScrollView.h"

@interface FSPaginatedScrollView() <UIScrollViewDelegate>
@end

@implementation FSPaginatedScrollView

@synthesize appViews = _appViews;
@synthesize scrollView = _scrollView;
@synthesize currentPage = _currentPage;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Initialization code
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        self.appViews = [NSMutableArray arrayWithObjects:nil];    

        [self initialize];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.scrollView];
        
        self.appViews = [NSMutableArray arrayWithObjects:nil];    

        self.currentPage = 0;
        [self initialize];
    }
    return self;
}


- (void) initialize 
{
    [self updateScrollView];
    
    NSLog(@"Starting index: %d", self.currentPage);
    NSLog(@"Scroll Content Height: %f", self.scrollView.contentSize.height);
    [self loadScrollViewWithPage:self.currentPage - 1];
    [self loadScrollViewWithPage:self.currentPage];
    [self loadScrollViewWithPage:self.currentPage + 1];
}

#pragma mark - 
#pragma mark Manage Views

- (void) updateScrollView {
    int width = self.scrollView.frame.size.width;
    
    self.scrollView.contentSize = CGSizeMake(width * [self.appViews count], self.scrollView.frame.size.height);
    [self.scrollView scrollRectToVisible:CGRectMake(self.currentPage * width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:NO];
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= [self.appViews count]) return;
    
    
	UIView *testView = [self.appViews objectAtIndex:page];
    if ((NSNull *)testView == [NSNull null]) {
        testView = [self viewForPage:page];
        
        [self.appViews replaceObjectAtIndex:page withObject:testView];
    }
    
    if (testView.superview == nil) {
        // add the controller's view to the scroll view
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        frame.size.height = self.scrollView.contentSize.height;
        
        testView.frame = frame;
        NSLog(@"Test Frame width: %f height: %f", frame.size.width, frame.size.height);
        NSLog(@"Adding Frame width: %f height: %f", self.scrollView.contentSize.width, self.scrollView.contentSize.height);
        [self.scrollView addSubview:testView];
    }
}

- (FSView*) viewForPage:(int)page
{
    @throw @"Overridden";
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (page < 0 || page >= [self.appViews count]) {
        return;
    }  
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// TODO call view did appear and disappear methods
    if (page > 0) {
        FSView *appView = [self.appViews objectAtIndex:page - 1];
        [appView viewDidDisappear];
    }
    if (page < [self.appViews count] - 1) {
        FSView *appView = [self.appViews objectAtIndex:page + 1];
        [appView viewDidDisappear];
    }
    
    FSView *appView = [self.appViews objectAtIndex:page];
    [appView viewDidAppear];
    
    self.currentPage = page;
}

@end
