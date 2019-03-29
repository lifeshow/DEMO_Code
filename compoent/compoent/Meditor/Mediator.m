//
//  Mediator.m
//  compoent
//
//  Created by closureJan on 2019/3/29.
//  Copyright © 2019年 jian.yang. All rights reserved.
//

#import "Mediator.h"

@interface Mediator ()

@property(nonatomic, strong) NSMutableDictionary *cacheTarget;

@end

@implementation Mediator

+(instancetype)shareInstance
{
    static Mediator *diator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        diator = [[Mediator alloc]init];
    });
    
    return diator;
}

-(id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget
{
    NSString *targetClassString = [NSString stringWithFormat:@"MoudleTatget_%@",targetName];
    
    //获取方法调用的对象
    NSObject *target = self.cacheTarget[targetClassString];
    if (target ==nil)
    {
        Class targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
        
    }
    
    //获取方法
    NSString *actionString = [NSString stringWithFormat:@"MoudleTatget_%@:", actionName];
    SEL action = NSSelectorFromString(actionString);
    
    
    if (target == nil)
    {
        //指定一个方法来解决
        return nil;
    }
    
    if (shouldCacheTarget)
    {
        self.cacheTarget[targetClassString] = target;
    }
    
    if ([target respondsToSelector:action])
    {
      return   [self safePerformAction:action target:target params:params];
        
    }else
    {
        [self.cacheTarget removeObjectForKey:targetClassString];
        return nil;
    }
}


-(void)releaseCachedTargetWithTargetName:(NSString *)targetName
{
    NSString *targetClassString = [NSString stringWithFormat:@"MoudleTarget_%@", targetName];
    [self.cacheTarget removeObjectForKey:targetClassString];
}

- (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params
{
    NSMethodSignature* methodSig = [target methodSignatureForSelector:action];
    if (methodSig == nil)
    {
        return nil;
    }
    //对于基本数据类型的返回处理
    const char* retType = [methodSig methodReturnType];
    
    if (strcmp(retType, @encode(void)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        return nil;
    }
    
    if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(BOOL)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(CGFloat)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    
}

-(NSMutableDictionary *)cacheTarget
{
    if (!_cacheTarget)
    {
        _cacheTarget = [[NSMutableDictionary alloc]init];
    }
    
    return _cacheTarget;
}

@end
