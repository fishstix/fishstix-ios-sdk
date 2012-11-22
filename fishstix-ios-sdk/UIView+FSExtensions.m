//
//  UIView+FSExtensions.m
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 11/21/12.
//
//

#import "UIView+FSExtensions.h"

@implementation UIView (FSExtensions)

+ (id) initWithNibName:(NSString *)nibName withSelf:(id)myself {
    
    NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:nibName
                                                    owner:myself options:nil];
    for (id object in bundle) {
        if ([object isKindOfClass:[myself class]]) {
            return object;
        }
    }
    
    return nil;
}

@end
