//
//  LogInViewModel.m
//  ReactiveCocoa-MVVM
//
//  Created by mingxin.ji on 2019/3/13.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import "LogInViewModel.h"

@implementation Account



@end

@implementation LogInViewModel

-(Account *)account
{
    if (!_account)
    {
        _account = [[Account alloc]init];
    }
    
    return _account;
}

-(instancetype)init
{
    if (self = [super init])
    {
        [self initBind];
    }
    
    return self;
}

-(void)initBind
{
    
    
    __weak LogInViewModel *weakSelf = self;
    _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(weakSelf.account, account),RACObserve(weakSelf.account, pwd)] reduce:^id(NSString *account, NSString *pwd){
       
        return @(account.length && account.length<=11 && pwd.length>6 && pwd.length<12);
    }];
    
    
    
    
    _LoginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        NSLog(@"点击了登录");
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
            
            dispatch_async(queue, ^{
                sleep(5);
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    [subscriber sendNext:@"登录成功"];
                    [subscriber sendCompleted];
                });
                
            });
            
            return nil;
        }];
        
    }];
    
    

    //监听登录状态
    [[_LoginCommand .executing skip:1]subscribeNext:^(id x) {
       
        if ([x isEqualToNumber:@(YES)])
        {
            NSLog(@"请求开始");
        }else
        {
            NSLog(@"请求结束");
        }
        
    }];
}
@end
