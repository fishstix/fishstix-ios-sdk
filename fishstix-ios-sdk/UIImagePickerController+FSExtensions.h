//
//  UIImagePickerController+FSExtensions.h
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 12/13/12.
//
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (FSExtensions)
- (id)initWithCompletionBlock:(void (^)(UIImagePickerController *pickerController, NSDictionary *info))block cancelBlock:(void (^)(UIImagePickerController *pickerController))cancelBlock;
@end
