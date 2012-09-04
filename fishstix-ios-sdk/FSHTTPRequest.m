//
//  FSHTTPRequest.m
//  FishStix
//
//  Created by Charles Fisher on 7/14/12.
//  Copyright (c) 2012 WinFish. All rights reserved.
//

#import "FSHTTPRequest.h"

@implementation FSHTTPRequest

@synthesize completionBlock = _completionBlock;
@synthesize failureBlock = _failureBlock;

- (void) start:(HTTPRequestDataBlock)completion :(HTTPRequestBlock)failure
{
    self.delegate = self;
    self.completionBlock = completion;
    self.failureBlock = failure;
    [self start];
}

- (void) request:(HTTPRequest *)request failed:(NSError *)error
{
    self.failureBlock(self);
}

- (void) request:(HTTPRequest *)request receivedData:(NSData *)data
{
    self.completionBlock(data);
}

@end
