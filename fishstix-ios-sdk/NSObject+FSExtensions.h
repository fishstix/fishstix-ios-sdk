//
//  NSObject+FSExtensions.h
//  RockTok
//
//  Created by Charles Fisher on 8/3/12.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (FSExtensions)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;


@end
