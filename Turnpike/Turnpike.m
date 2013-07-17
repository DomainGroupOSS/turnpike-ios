//
//  Turnpike.m
//  Turnpike
//
//  Created by James Lawrence Turner on 7/5/13.
//  Copyright (c) 2013 URX. All rights reserved.
//

#import "Turnpike.h"
#import "TPHelper.h"

@interface Turnpike()

+(TPRouter *)sharedRouter;

@end

@implementation Turnpike

+(TPRouter *)sharedRouter
{
    static dispatch_once_t pred = 0;
    __strong static TPRouter *_sharedRouter = nil;
    dispatch_once(&pred, ^{
        _sharedRouter = [TPRouter router];
    });
    return _sharedRouter;
}

+ (void)mapRoute:(NSString *)format ToCallback:(TPRouteDestination)callback {
    [[self sharedRouter] mapRoute:format ToCallback:callback];
}

+ (void)mapDefaultToCallback:(TPRouteDestination)callback {
    [[self sharedRouter] mapDefaultToCallback:callback];
}

+ (void)addFilter:(id <TPFilterProtocol>)filter {
    [[self sharedRouter] appendFilter:filter];
}

+ (void)addAnonymousFilter:(TPFilterBlock)filterBlock {
    [[self sharedRouter] appendAnonymousFilter:filterBlock];
}

+ (void)resolveURL:(NSURL *)url {
    [[self sharedRouter] resolveURL:url];
}

@end
