//
//  FSHTTPRequest.h
//  FishStix
//
//  Created by Charles Fisher on 7/14/12.
//  Copyright (c) 2012 WinFish. All rights reserved.
//

#import "HTTPRequest.h"

@class FSHTTPRequest;

typedef void(^HTTPRequestDataBlock)(NSData*);
typedef void(^HTTPRequestBlock)(FSHTTPRequest*);

@interface FSHTTPRequest : HTTPRequest <HTTPRequestDelegate>
{
    HTTPRequestDataBlock _completionBlock;
    HTTPRequestBlock _failureBlock;
}

@property (nonatomic, strong) HTTPRequestDataBlock completionBlock;
@property (nonatomic, strong) HTTPRequestBlock failureBlock;

- (void) start:(HTTPRequestDataBlock)completion :(HTTPRequestBlock)failure;
@end
