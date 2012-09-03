//
//  NSObject+FSExtensions.m
//  RockTok
//
//  Created by Charles Fisher on 8/3/12.
//
//

#import "NSObject+FSExtensions.h"

#include <sys/types.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <net/if_dl.h>
#include <ifaddrs.h>

@implementation NSObject (FSExtensions)

//- (void) blah
//{
//    unsigned int outCount, i;
//    
//    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
//    for(i = 0; i < outCount; i++) {
//        objc_property_t property = properties[i];
//        const char *propName = property_getName(property);
//        if(propName) {
//            const char *propType = getPropertyType(property);
//            NSString *propertyName = [NSString stringWithUTF8String:propName];
//            NSString *propertyType = [NSString stringWithUTF8String:propType];
//        }
//    }
//    free(properties);
//}

@end
