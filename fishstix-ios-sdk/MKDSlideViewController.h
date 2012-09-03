//
//  MKDSlideViewController.h
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 03.12.11.
//  Copyright (c) 2011 Marcel Dierkes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>  // Don't forget to add the QuartzCore Framework to your project

#define kSlideSpeed 0.3f
#define kSlideOverlapWidth 52.0f;

@interface MKDSlideViewController : UIViewController

@property (nonatomic, retain) UIViewController * leftViewController;
@property (nonatomic, retain) UIViewController * rightViewController;
@property (nonatomic, retain) UINavigationController * rootNavController;
@property (nonatomic, retain) UIViewController * rootViewController;

@property (nonatomic, retain) UIBarButtonItem * menuBarButtonItem;

@property (nonatomic, assign) BOOL hidesMenuButton;

- (id)initWithRootViewController:(UIViewController *)rootViewController;
- (void)setLeftViewController:(UIViewController *)leftViewController rightViewController:(UIViewController *)rightViewController;

- (IBAction)showLeftViewController:(id)sender;
- (IBAction)showRightViewController:(id)sender;
- (IBAction)showMainViewController:(id)sender;

- (void) setRootViewControllers:(NSArray*) rootControllers;

@end

@protocol MKDSlideViewControllerDelegate <NSObject>

- (void)slideViewController:(MKDSlideViewController *)svc willSlideToViewController:(UIViewController *)vc;
- (void)slideViewController:(MKDSlideViewController *)svc didSlideToViewController:(UIViewController *)vc;

@end