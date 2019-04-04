//
//  Mediator+MoudleTarger_B.m
//  compoent
//
//  Created by closureJan on 2019/3/29.
//  Copyright © 2019年 jian.yang. All rights reserved.
//

#import "Mediator+MoudleTarger_B.h"

NSString * const kCTMediatorTargetB = @"B";

@implementation Mediator (MoudleTarger_B)

-(UIViewController *)gotoMoudleBControlerCompleteBlock:(void (^)(NSDictionary *))block
{
    NSDictionary *parmers = @{@"block":block};
    
    return [self performTarget:kCTMediatorTargetB action:@"loadController" params:parmers shouldCacheTarget:NO];
    
}

@end
