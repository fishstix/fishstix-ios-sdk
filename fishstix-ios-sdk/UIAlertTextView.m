//
//  UIAlertTextView.m
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 12/13/12.
//
//

#import "UIAlertTextView.h"

#import "UIAlertView+BlockExtensions.h"

@interface UIAlertTextView() <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation UIAlertTextView

- (id) initWithTitle:(NSString *)title completionBlock:(void (^)(NSString *text, UIAlertTextView *alert))block cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle
{
    return [super initWithTitle:title message:@"\r\n\r\n" completionBlock:^(NSUInteger index, UIAlertView *alertView) {
        if (index == [alertView cancelButtonIndex]) {
            block(nil, self);
        } else {
            block(self.textField.text, self);
        }
    } cancelButtonTitle:cancelButtonTitle otherButtonTitles:okButtonTitle, nil];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [self.textField setBackgroundColor:[UIColor whiteColor]];
    [self.textField setDelegate:self];
    [self addSubview:self.textField];
}

- (void) show
{
    [super show];
    
//    [self performBlock:^(void) {
//        [self.textField becomeFirstResponder];
//    } afterDelay:0.4f];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    
}

@end
