//
//  DMNetWorkAgent.m
//  Builder_Pattern
//
//  Created by mingxin.ji on 2019/3/27.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import "DMNetWorkAgent.h"
#import "AFNetworking.h"
#import "DMNetWorkCache.h"

#define Lock() pthread_mutex_lock(&_lock)
#define Unlock() pthread_mutex_unlock(&_lock)

@interface DMNetWorkAgent()

{
    AFHTTPSessionManager *_manager;
    NSMutableDictionary * _requestsRecord;
}
@end

@implementation DMNetWorkAgent

+ (instancetype)shareAgent
{
    return [[self alloc]init];
}

-(instancetype)init
{
    if (self = [super init])
    {
          _manager = [AFHTTPSessionManager manager];
        _requestsRecord = [[NSMutableDictionary alloc]init];
    }
    return self;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    static DMNetWorkAgent * singleAgent;
    dispatch_once(&onceToken, ^{
        singleAgent = [[super allocWithZone:NULL]init];
        
        
    });
    
    return singleAgent;
}

- (void)addRequest:(DMBaseRequest *)request
{
    if (request)
    {
        request.requestTask = [self sessionTaskForRequest:request error:nil];
        [self addRequestToRecord:request];
       
    }
}

- (void)cancelRequest: (DMBaseRequest *)request
{
     NSParameterAssert(request != nil);
    [request.requestTask cancel];
    request.successCompletionBlock = nil;
    request.failureCompletionBlock = nil;
     [self removeRequestFromRecord:request];
}

-(NSURLSessionTask *)sessionTaskForRequest:(DMBaseRequest *)request error: (NSError * _Nullable __autoreleasing *)error
{
    DMRequestMethod method = [request requestMethod];
    NSString *url = [self buildRequestUrl:request];
    AFHTTPRequestSerializer *requestSerializer = [self requestSerializerForRequest:request];
    _manager.requestSerializer = requestSerializer;
    NSDictionary * parmer = [request requestParameters];

    switch (method) {
        case DMRequestMethodGet:
        {
            
           return  [_manager GET:url parameters:parmer progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               [self handleRequestResult:task responseObject:responseObject error:nil];
               
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [self handleRequestResult:task responseObject:nil error:error];
                
            }];
            
          
        }
            break;
        
        case DMRequestMethodPost:
        {
           return  [_manager POST:url parameters:parmer progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestResult:task responseObject:responseObject error:nil];
               
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                 [self handleRequestResult:task responseObject:nil error:error];
            }];
        }
            break;
        
    }
    
    return nil;
}


#pragma mark-获取UrlString------
- (NSString *)buildRequestUrl:(DMBaseRequest *)request
{
    return [NSString stringWithFormat:@"%@%@",[request baseUrl],[request requestUrl]];
}

- (AFHTTPRequestSerializer *)requestSerializerForRequest:(DMBaseRequest *)request
{
    AFHTTPRequestSerializer *requestSerializer = nil;
    
    if (request.requestSerializerType == DMRequestSerializerTypeHTTP)
    {
         requestSerializer = [AFHTTPRequestSerializer serializer];
        
    }else if (request.requestSerializerType == DMRequestSerializerTypeJSON)
    {
        requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    requestSerializer.timeoutInterval = [request requestTimeoutInterval];
    
      NSDictionary<NSString *, NSString *> *headerFieldValueDictionary = [request headerField];
    if (headerFieldValueDictionary != nil)
    {
        [headerFieldValueDictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            
             [requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    
    return requestSerializer;
    
}

- (void)addRequestToRecord:(DMBaseRequest *)request {
   
    _requestsRecord[@(request.requestTask.taskIdentifier)] = request;

}

- (void)removeRequestFromRecord:(DMBaseRequest *)request {

    [_requestsRecord removeObjectForKey:@(request.requestTask.taskIdentifier)];
 
}
- (void)handleRequestResult:(NSURLSessionTask *)task responseObject:(id)responseObject error:(NSError *)error
{
    BOOL success = NO;
    DMBaseRequest * request = _requestsRecord[@(task.taskIdentifier)];
    request.responseObject = responseObject;
    request.error = error;
    
   
    
    if (success)
    {
        if ([request writeCacheAsynchronously] && responseObject)
        {
            dispatch_queue_t write_Seri_Queue = dispatch_queue_create("write.seri.queue", DISPATCH_QUEUE_SERIAL);
            dispatch_async(write_Seri_Queue, ^{
                
                [DMNetWorkCache saveCacheDataWithRequest:request];
                
            });
            
            
        }
        if (request.delegate && [request.delegate respondsToSelector:@selector(requestFinished:)])
        {
            [request.delegate requestFinished:request];
        }
        
        if (request.successCompletionBlock)
        {
            request.successCompletionBlock(request);
        }
        
      
    }else
    {
        if (request.delegate && [request.delegate respondsToSelector:@selector(requestFailed:)])
        {
            [request.delegate requestFailed:request];
        }
        
        if (request.failureCompletionBlock)
        {
            request.failureCompletionBlock(request);
        }
    }
    
  
   
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self removeRequestFromRecord:request];
    });
}
@end
