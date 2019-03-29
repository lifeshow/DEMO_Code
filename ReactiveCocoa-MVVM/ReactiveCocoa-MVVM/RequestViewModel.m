//
//  RequestViewModel.m
//  ReactiveCocoa-MVVM
//
//  Created by mingxin.ji on 2019/3/13.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import "RequestViewModel.h"
#import <AFNetworking.h>


@implementation RequestViewModel

-(instancetype)init
{
    if (self = [super init])
    {
        [self initialBind];
    }
    
    return self;
}

-(void)initialBind
{
    _requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
       
        RACSignal *requestSign = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        
            
            [manager GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":@"基础"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [subscriber sendNext:responseObject];
                
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            
            
            
            
            return nil;
        }];
        
        return requestSign;
//        return [requestSign map:^id(id value) {
//
//            NSMutableArray *dicArr = value[@"books"];
//            NSArray *domelArr = [dicArr.rac_sequence map:^id(id value) {
//
//            }]
//            return nil;
//        }];
//
//
   }];
    
    [_requestCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        
    }];
}
@end
