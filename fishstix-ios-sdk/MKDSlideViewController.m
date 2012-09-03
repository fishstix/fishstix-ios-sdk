//
//  MKDSlideViewController.m
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 03.12.11.
//  Copyright (c) 2011 Marcel Dierkes. All rights reserved.
//

#import "MKDSlideViewController.h"

@interface MKDSlideViewController ()

@property (nonatomic, retain) UIViewController * mainViewController;
@property (nonatomic, retain) UIView * mainContainerView;
@property (nonatomic, retain) UIView * mainTapView;
@property (nonatomic, retain) UIPanGestureRecognizer * panGesture;
@property (nonatomic) CGPoint previousLocation;

- (void)setupPanGestureForView:(UIView *)view;
- (void)panGesture:(UIPanGestureRecognizer *)gesture;
- (void)addTapViewOverlay;
- (void)removeTapViewOverlay;

@end

@implementation MKDSlideViewController

@synthesize leftViewController = _leftViewController, rightViewController = _rightViewController;
@synthesize rootViewController = _rootViewController;
@synthesize rootNavController = _rootNavController;
@synthesize panGesture = _panGesture, menuBarButtonItem = _menuBarButtonItem;
@synthesize mainViewController = _mainViewController, mainContainerView = _mainContainerView, mainTapView = _mainTapView;
@dynamic hidesMenuButton;

@synthesize previousLocation = _previousLocation;

- (id)initWithRootViewController:(UIViewController *)rootViewController;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.rootViewController = rootViewController;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIView * containerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 460.0)];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    containerView.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    
    if( self.rootViewController )
    {
        // Wrap inside Navigation Controller
//        self.rootNavController = [RTNavigationController rtNavigationControllerWithViewController:self.rootViewController];
        self.rootNavController = [[UINavigationController alloc] initWithRootViewController:self.rootViewController];
        
        [self setupPanGestureForView:self.rootNavController.navigationBar];
        
        self.mainViewController = self.rootNavController;
        [self addChildViewController:self.mainViewController];
        self.mainViewController.view.clipsToBounds = YES;
        
        // Add menu item
        if( self.menuBarButtonItem == nil ) {
            UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *menuImg = [UIImage imageNamed:@"icon_menu_normal"];
            UIImage *menuPressedImg = [UIImage imageNamed:@"icon_menu_touched"];
            [menuButton setImage:menuImg forState:UIControlStateNormal];
            [menuButton setImage:menuPressedImg forState:UIControlStateHighlighted];
            [menuButton setFrame:CGRectMake(0,0,menuImg.size.width,menuImg.size.height)];
            [menuButton addTarget:self action:@selector(showLeftViewController:) forControlEvents:UIControlEventTouchUpInside];

            _menuBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
        }
            
        self.rootViewController.navigationItem.leftBarButtonItem = self.menuBarButtonItem;

        // Add layer shadow
        CALayer * mainLayer = [self.mainViewController.view layer];
        mainLayer.masksToBounds = NO;
        CGPathRef pathRect = [UIBezierPath bezierPathWithRect:self.mainViewController.view.bounds].CGPath;
        mainLayer.shadowColor = [UIColor blackColor].CGColor;
        mainLayer.shadowOffset = CGSizeMake(0.0, 0.0);
        mainLayer.shadowOpacity = 1.0f;
        mainLayer.shadowPath = pathRect;
        mainLayer.shadowRadius = 20.0f;
        
        [containerView addSubview:self.mainViewController.view];
    }
    
    self.view = containerView;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Set Controllers

- (void) setRootViewControllers:(NSArray*) rootControllers
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];

    [animation setRemovedOnCompletion:YES];

    [[self.rootNavController.view layer] addAnimation:animation forKey:nil];

    [self.rootNavController setViewControllers:rootControllers];

    [self setHidesMenuButton:NO];
}

#pragma mark - Sub View Controllers

- (void)setLeftViewController:(UIViewController *)leftViewController rightViewController:(UIViewController *)rightViewController
{
    [self.mainViewController.view removeFromSuperview];
    
    self.leftViewController = leftViewController;
    self.rightViewController = rightViewController;
    
    if( self.leftViewController != nil )
    {
        [self addChildViewController:self.leftViewController];
        [self.view addSubview:self.leftViewController.view];
    }
    
    if( self.rightViewController != nil )
    {
        [self addChildViewController:self.rightViewController];
        [self.view addSubview:self.rightViewController.view];
    }
    
    [self.view addSubview:self.mainViewController.view];
}

#pragma mark -
#pragma mark MENU

- (void) setHidesMenuButton:(BOOL)hidesMenuButton
{
    // Set Menu Button
    for (UIViewController *vc in self.rootNavController.viewControllers) {
        vc.navigationItem.leftBarButtonItem = hidesMenuButton ? nil : self.menuBarButtonItem;
    }
}

- (BOOL) hidesMenuButton
{
    UIViewController *vc = [self.rootNavController.viewControllers objectAtIndex:0];
    return vc.navigationItem.leftBarButtonItem != self.menuBarButtonItem;
}

#pragma mark - Panning

- (void)setupPanGestureForView:(UIView *)view
{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    pan.maximumNumberOfTouches = 1;
    self.panGesture = pan;
    [view addGestureRecognizer:pan];
//    [pan release];
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture
{
    if (self.hidesMenuButton) {
        return;
    }
    
    if( gesture.state == UIGestureRecognizerStateBegan )
    {
        self.previousLocation = CGPointZero;
    }
    else if( gesture.state == UIGestureRecognizerStateChanged )
    {
        // Decide, which view controller should be revealed
        if( self.mainViewController.view.frame.origin.x <= 0.0f ) // left
            [self.view sendSubviewToBack:self.leftViewController.view];
        else 
            [self.view sendSubviewToBack:self.rightViewController.view];
        
        // Calculate position offset
        CGPoint locationInView = [gesture translationInView:self.view];
        CGFloat deltaX = locationInView.x - self.previousLocation.x;
        
        // Update view frame
        CGRect newFrame = self.mainViewController.view.frame;
        newFrame.origin.x +=deltaX;
        CGFloat max = newFrame.size.width - kSlideOverlapWidth;
        newFrame.origin.x = newFrame.origin.x > max ? max : newFrame.origin.x;
        CGFloat min = 0; // Don't slide to reveal right side
        newFrame.origin.x = newFrame.origin.x < min ? min : newFrame.origin.x;
        self.mainViewController.view.frame = newFrame;
        
        self.previousLocation = locationInView;
    }
    else if( (gesture.state == UIGestureRecognizerStateEnded) || (gesture.state == UIGestureRecognizerStateCancelled) )
    {
        CGFloat xOffset = self.mainViewController.view.frame.origin.x;

        // snap to zero
        if( (xOffset <= (self.mainViewController.view.frame.size.width/2)) && (xOffset >= (-self.mainViewController.view.frame.size.width/2)) )
        {
            [self showMainViewController:nil];
        }
        // reveal right view controller
        else if( xOffset < (-self.mainViewController.view.frame.size.width/2) )
        {
            [self showRightViewController:nil];
        }
        // reveal left view controller
        else
        {
            [self showLeftViewController:nil];
        }
        
        self.previousLocation = CGPointZero;
    }
}

#pragma mark - Tappable View Overlay

- (void)addTapViewOverlay
{
    if( self.mainTapView == nil )
    {
        _mainTapView = [[UIView alloc] initWithFrame:self.mainViewController.view.bounds];
        self.mainTapView.backgroundColor = [UIColor clearColor];
        
        // Tap Gesture
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMainViewController:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        
        [self.mainTapView addGestureRecognizer:tap];
//        [tap release];
        
        // Pan Gesture
        [self setupPanGestureForView:self.mainTapView];
    }
    else
        self.mainTapView.frame = self.mainViewController.view.bounds;
    
    [self.mainViewController.view addSubview:self.mainTapView];
}

- (void)removeTapViewOverlay
{
    if( self.mainTapView != nil )
        [self.mainTapView removeFromSuperview];
}

#pragma mark - Slide Actions

- (IBAction)showLeftViewController:(id)sender
{
    [self.view sendSubviewToBack:self.rightViewController.view];
    
    [UIView animateWithDuration:kSlideSpeed animations:^{
        CGRect theFrame = self.mainViewController.view.frame;
        theFrame.origin.x = theFrame.size.width - kSlideOverlapWidth;
        self.mainViewController.view.frame = theFrame;
    } completion:^(BOOL finished) {
        [self addTapViewOverlay];
    }];
}

- (IBAction)showRightViewController:(id)sender
{
    [self.view sendSubviewToBack:self.leftViewController.view];  // FIXME: Correct timing, when sending to back
    
    [UIView animateWithDuration:kSlideSpeed animations:^{
        CGRect theFrame = self.mainViewController.view.frame;
        theFrame.origin.x = -theFrame.size.width + kSlideOverlapWidth;
        self.mainViewController.view.frame = theFrame;
    } completion:^(BOOL finished) {
        [self addTapViewOverlay];
    }];
}

- (IBAction)showMainViewController:(id)sender
{
    if( self.mainViewController.view.frame.origin.x != CGPointZero.x )
    {
        [UIView animateWithDuration:kSlideSpeed animations:^{
            CGRect theFrame = self.mainViewController.view.frame;
            theFrame.origin = CGPointZero;
            self.mainViewController.view.frame = theFrame;
        } completion:^(BOOL finished) {
            [self removeTapViewOverlay];
        }];
        
    }
}

#pragma mark - Container View Controller

/* // No need for override
- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers
{
    return [super automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers];
}

- (void)addChildViewController:(UIViewController *)childController
{
    [super addChildViewController:childController];
}

- (void)removeFromParentViewController
{
    [super removeFromParentViewController];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
}
*/

@end
