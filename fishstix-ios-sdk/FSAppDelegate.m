//
//  FSAppDelegate.m
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 6/26/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "FSAppDelegate.h"

#import <QuartzCore/QuartzCore.h>

@implementation FSAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (!self.window) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        // Override point for customization after application launch.
        self.window.backgroundColor = [UIColor whiteColor];
<<<<<<< HEAD
        [self.window makeKeyAndVisible];        
    }
    
    // Fade in from Default.png
    [self downloadUserObject];
    
=======
        [self.window makeKeyAndVisible];
    }
>>>>>>> 1c0166f2b357b55eeee44bb649fc78baeb11e60c
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

    // Fade in from Default.png
    [self fadeOutDefaultPNG];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark -
#pragma mark DEFAULT.PNG

static UIViewController *coverVC = NULL;

- (void) downloadUserObject {
    [self showDefaultPNG];
    
    [self initializeUser];
}

- (void) showDefaultPNG
{
    // Default.png
    if (coverVC == NULL) {
        coverVC = [[UIViewController alloc] init];
        
        UIView *coverView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
        [coverView setFrame:CGRectMake(0, 0, coverVC.view.frame.size.width, coverVC.view.frame.size.height)];
        [coverView setUserInteractionEnabled:YES];
        
        [coverVC.view addSubview:coverView];
        
        UIActivityIndicatorView *loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [loader setCenter:CGPointMake(coverView.frame.size.width / 2, 50 + coverView.frame.size.height / 2)];
        [loader startAnimating];
        [coverView addSubview:loader];
    }
    
    if ([UIWindow topMostController] == coverVC) {
        return;
    }
    [[UIWindow topMostController] presentModalViewController:coverVC animated:NO];
}

- (void) removeDefaultPNG
{
    if (coverVC != NULL) {
        [coverVC dismissModalViewControllerAnimated:NO];
        
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.3f];
        [animation setType:kCATransitionFade];
        [animation setRemovedOnCompletion:YES];
        
        UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
        [appWindow.layer addAnimation:animation forKey:@"default"];
    }
}

- (void) fadeOutDefaultPNG
{
    // Check for Snapshot of App first
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *snapshotsDir = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"Snapshots/%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]]];
    
    DLog(@"Snapshots: %@", snapshotsDir);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:snapshotsDir]) {
        DLog(@"Contents: %@", [[NSFileManager defaultManager] contentsOfDirectoryAtPath:snapshotsDir error:nil]);
        
        if ([[[NSFileManager defaultManager] contentsOfDirectoryAtPath:snapshotsDir error:nil] count] > 0) {
            // Make sure we initialize
            [self initializeUser];
            return;
        }
    }
    
//    [self downloadUserObject];
}

- (void) initializeUser
{
//    [[RTServiceProvider serviceProvider] getUser:^(BOOL success){
//        // Dispatch to Main Thread
        dispatch_async(dispatch_get_main_queue(), ^(void){
//            if (success) {
            [NSThread sleepForTimeInterval:3.0f];
                [self removeDefaultPNG];
//            } else {
//                [[[RTAlertView alloc] initWithTitle:@"" message:@"Internet Connection Required" completionBlock:^(NSUInteger btnIndex, UIAlertView *alertView) {
//                } cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//            }
        });
//    }];
}


@end
