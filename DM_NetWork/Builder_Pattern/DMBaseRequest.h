//
//  DMBaseRequest.h
//  Builder_Pattern
//
//  Created by mingxin.ji on 2019/3/27.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求方式
typedef enum : NSUInteger {
    DMRequestMethodGet = 0,
    DMRequestMethodPost ,
} DMRequestMethod;


///Request serializer type.
typedef enum : NSUInteger {
    
    DMRequestSerializerTypeHTTP=0,
    DMRequestSerializerTypeJSON,
    
}DMRequestSerializerType;

///  the type of `responseObject`.返回结果类型

typedef enum : NSUInteger {
    DMResponseSerializerTypeHTTP = 0,
    DMResponseSerializerTypeJSON,
    DMResponseSerializerTypeXMLParser,
} DMResponseSerializerType;


@class DMBaseRequest;
@protocol DMRequestDelegate <NSObject>

//请求成功
- (void)requestFinished:(__kindof DMBaseRequest *)request;

//请求失败
- (void)requestFailed:(__kindof DMBaseRequest *)request;

@end


//请求返回的Block
typedef void(^DMRequestCompletionBlock)(DMBaseRequest *request);



@interface DMBaseRequest : NSObject


#pragma mark-请求的调用方法----

-(void)start;

-(void)stop;

- (void)startWithCompletionBlockWithSuccess:(nullable DMRequestCompletionBlock)success
                                    failure:(nullable DMRequestCompletionBlock)failure;

@property(nonatomic, copy)id<DMRequestDelegate> delegate;

@property (nonatomic, copy, nullable) DMRequestCompletionBlock successCompletionBlock;

@property (nonatomic, copy, nullable) DMRequestCompletionBlock failureCompletionBlock;
#pragma mark-获取请求相关数据--

@property (nonatomic, strong, readwrite) NSURLSessionTask *requestTask;

@property (nonatomic, readonly) NSInteger responseStatusCode;

@property (nonatomic, strong, readwrite) id responseObject;

@property (nonatomic, strong, readwrite) NSString *responseString;

@property (nonatomic, strong, readwrite) NSError *error;


#pragma mark-子类重写方法--


- (NSString *)baseUrl;

- (NSString *)requestUrl;

- (NSTimeInterval)requestTimeoutInterval;

- (NSDictionary *)headerField;

- (NSDictionary *)requestParameters;

- (NSSet *)acceptableContentTypes;

- (DMRequestMethod)requestMethod;

- (DMRequestSerializerType)requestSerializerType;

- (DMResponseSerializerType)responseSerializerType;



//缓存
- (BOOL)writeCacheAsynchronously;

- (NSInteger)cacheTimeInSeconds;

- (void)loadCache:(nullable DMRequestCompletionBlock)cacheBlock;


@end
