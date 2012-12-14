//
//  UIImagePickerController+FSExtensions.m
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 12/13/12.
//
//

#import "UIImagePickerController+FSExtensions.h"

#import <objc/runtime.h>

@interface UIImagePickerController() <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end

@implementation UIImagePickerController (FSExtensions)

- (id)initWithCompletionBlock:(void (^)(UIImagePickerController *pickerController, NSDictionary *info))block cancelBlock:(void (^)(UIImagePickerController *pickerController))cancelBlock
{
    self = [self init];
    if (self) {
        // Custom initialization
        self.delegate = self;
        objc_setAssociatedObject(self, "blockCallback", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, "cancelBlockCallback", [cancelBlock copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return self;
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    void (^block)(UIImagePickerController *picker, NSDictionary *info) = objc_getAssociatedObject(self, "blockCallback");
	block(self, info);
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    void (^block)(UIImagePickerController *picker) = objc_getAssociatedObject(self, "cancelBlockCallback");
	block(self);
    
    [self dismissModalViewControllerAnimated:YES];
}


@end
