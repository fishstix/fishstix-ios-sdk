//
//  FSUtil.h
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 11/14/12.
//
//

#import <Foundation/Foundation.h>

@interface FSUtil : NSObject

+ (NSString*) appName;
/*
 *  Returns app version e.g. 2.1.8
 */
+ (NSString*) appVersion;
+ (NSNumber*) appVersionNumber;
+ (NSString*) macAddress;

@end
