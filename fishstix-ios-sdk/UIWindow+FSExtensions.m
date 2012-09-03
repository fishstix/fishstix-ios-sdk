//
//  UIWindow+FSExtensions.m
//  RockTok
//
//  Created by Charles Fisher on 8/3/12.
//
//

#import "UIWindow+FSExtensions.h"

@implementation UIWindow (FSExtensions)

+ (UIViewController*) topMostController
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    UIViewController *baseController = [window rootViewController];
    
    while (baseController.presentedViewController) {
        baseController = baseController.presentedViewController;
    }
    
    return baseController;
}

@end
