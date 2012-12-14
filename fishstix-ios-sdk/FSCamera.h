//
//  FSCamera.h
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 12/13/12.
//
//

#import <Foundation/Foundation.h>

typedef void(^ImageBlock)(UIImage *image);

@interface FSCamera : NSObject

+ (FSCamera*) sharedCamera;

- (void) takePicture:(ImageBlock)block;

@end
