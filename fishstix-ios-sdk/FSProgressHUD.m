//
//  FSProgressHUD.m
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 11/26/12.
//
//

#import "FSProgressHUD.h"

@implementation FSProgressHUD

+ (void) showHUDWithTitle:(NSString *)title forView:(UIView *)view
{
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    [hud setLabelText:title];
}

@end
