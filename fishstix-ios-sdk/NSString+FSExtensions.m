//
//  NSString+FSExtensions.m
//  RockTok
//
//  Created by Charles Fisher on 8/15/12.
//
//

#import "NSString+FSExtensions.h"

@implementation NSString (FSExtensions)

+ (NSString*) formattedTimeForSeconds:(int)seconds
{
    NSString *time = [NSString stringWithFormat:@"%d:%.2d", seconds / 60, seconds % 60];
    return time;
}

@end
