//
//  FSProgressHUD.h
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 11/26/12.
//
//

#import "MBProgressHUD.h"

@interface FSProgressHUD : MBProgressHUD

+ (void) showHUDWithTitle:(NSString*)title forView:(UIView*) view;

@end
