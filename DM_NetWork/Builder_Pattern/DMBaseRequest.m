//
//  DMBaseRequest.m
//  Builder_Pattern
//
//  Created by mingxin.ji on 2019/3/27.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import "DMBaseRequest.h"
#import "DMNetWorkAgent.h"
#import "DMNetWorkCache.h"

@implementation DMBaseRequest



- (NSString *)baseUrl
{
    return @"http//;192.168.82:8080";
}

- (NSString *)requestUrl
{
    return @"";
}

- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}

- (NSDictionary *)headerField;
{
    return @{};
}

- (NSDictionary *)requestParameters
{
    return @{};
}

- (NSSet *)acceptableContentTypes
{
    return [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
}

- (DMRequestMethod)requestMethod
{
    return DMRequestMethodPost;
}

- (DMRequestSerializerType)requestSerializerType
{
    return DMRequestSerializerTypeHTTP;
}

- (DMResponseSerializerType)responseSerializerType
{
    return DMResponseSerializerTypeJSON;
}


#pragma mark---缓存---
- (BOOL)writeCacheAsynchronously
{
    return NO;
}


- (NSInteger)cacheTimeInSeconds
{
    return -1;
}

-(void)loadCache:(DMRequestCompletionBlock)cacheBlock
{
    dispatch_queue_t seriQueue = dispatch_queue_create("cahce.com", DISPATCH_QUEUE_SERIAL);
    __block DMRequestCompletionBlock block = cacheBlock;
    dispatch_async(seriQueue, ^{
       
        [DMNetWorkCache loadCacheDataWithRequest:self];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (block)
            {
                block(self);
                block = nil;
            }
        });

        
    });
    
    }

//开始请求
- (void)start
{
     [[DMNetWorkAgent shareAgent] addRequest:self];
}


-(void)startWithCompletionBlockWithSuccess:(DMRequestCompletionBlock)success failure:(DMRequestCompletionBlock)failure
{
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
    [self start];
}

-(void)stop
{
    self.delegate = nil;
    [[DMNetWorkAgent shareAgent] cancelRequest:self];
}
@end
