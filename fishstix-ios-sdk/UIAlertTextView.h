//
//  UIAlertTextView.h
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 12/13/12.
//
//

#import <UIKit/UIKit.h>

@interface UIAlertTextView : UIAlertView

- (id)initWithTitle:(NSString *)title completionBlock:(void (^)(NSString *text, UIAlertTextView *alertView))block cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle;


@end
