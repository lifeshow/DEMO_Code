//
//  Mediator+MoudleTarget_A.m
//  compoent
//
//  Created by closureJan on 2019/3/29.
//  Copyright © 2019年 jian.yang. All rights reserved.
//

#import "Mediator+MoudleTarget_A.h"

NSString * const kCTMediatorTargetA = @"A";

@implementation Mediator (MoudleTarget_A)

-(UIViewController *)gotToMoudleAController
{
    UIViewController *controller = [self performTarget:kCTMediatorTargetA action:@"getMoudleAHomeController" params:nil shouldCacheTarget:YES];
    return controller;
}

@end
