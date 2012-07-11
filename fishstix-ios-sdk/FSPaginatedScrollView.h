//
//  FSPaginatedScrollView.h
//  Prayer
//
//  Created by Charles Fisher on 6/8/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "AppView.h"

@interface FSPaginatedScrollView : AppView {
    UIScrollView *_scrollView;

    NSMutableArray *_appViews;

    int _currentPage;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *appViews;
@property (nonatomic, assign) int currentPage;

- (void) initialize;
- (void) updateScrollView;
- (void) loadScrollViewWithPage:(int)page;
- (AppView*) viewForPage:(int)page;


@end
