//
//  NSDate+FSExtensions.m
//  RockTok
//
//  Created by Winfred Raguini on 8/4/12.
//  Copyright (c) 2012 WinFish. All rights reserved.
//

#import "NSDate+FSExtensions.h"

@implementation NSDate (FSExtensions)

- (NSString*)convertToGMT:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm";

    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    return [dateFormatter stringFromDate:date];
}
@end
