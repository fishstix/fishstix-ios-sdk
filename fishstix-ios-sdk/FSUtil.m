//
//  FSUtil.m
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 11/14/12.
//
//

#import "FSUtil.h"

#define IFT_ETHER 0x6

@implementation FSUtil

+ (NSString*) appName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString*) appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSNumber*) appVersionNumber
{
    NSString *appVersion = [FSUtil appVersion];
    
    NSArray *appVersionComponents = [appVersion componentsSeparatedByString:@"\\."];
    
    int build = 0;
    
    for (int i = 0; i < appVersionComponents.count; i++) {
        int component = [[appVersionComponents objectAtIndex:i] intValue];
        build += component * pow(10.0f, 3 * (appVersionComponents.count - (i + 1)));
    }
    
    return [NSNumber numberWithInt:build];
}

#include <sys/types.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <net/if_dl.h>
#include <ifaddrs.h>

+ (NSString*) macAddress
{
    char* macAddressString= (char*)malloc(18);
    NSString* macAddress= [[NSString alloc] initWithCString:getMacAddress(macAddressString,"en0")
                                                   encoding:NSMacOSRomanStringEncoding];
    return macAddress;
}

char*  getMacAddress(char* macAddress, char* ifName) {
    
    int  success;
    struct ifaddrs * addrs;
    struct ifaddrs * cursor;
    const struct sockaddr_dl * dlAddr;
    const unsigned char* base;
    int i;
    
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != 0) {
            if ( (cursor->ifa_addr->sa_family == AF_LINK)
                && (((const struct sockaddr_dl *) cursor->ifa_addr)->sdl_type == IFT_ETHER) && strcmp(ifName,  cursor->ifa_name)==0 ) {
                dlAddr = (const struct sockaddr_dl *) cursor->ifa_addr;
                base = (const unsigned char*) &dlAddr->sdl_data[dlAddr->sdl_nlen];
                strcpy(macAddress, "");
                for (i = 0; i < dlAddr->sdl_alen; i++) {
                    if (i != 0) {
                        strcat(macAddress, ":");
                    }
                    char partialAddr[3];
                    sprintf(partialAddr, "%02X", base[i]);
                    strcat(macAddress, partialAddr);
                    
                }
            }
            cursor = cursor->ifa_next;
        }
        
        freeifaddrs(addrs);
    }
    return macAddress;
}

@end
