//
//  UIAlertView+BlockExtensions.h
//
//  Created by Tom Fewster on 07/10/2011.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIAlertView (BlockExtensions) <UIAlertViewDelegate>

- (id)initWithTitle:(NSString *)title message:(NSString *)message completionBlock:(void (^)(NSUInteger buttonIndex, UIAlertView *alertView))block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end
