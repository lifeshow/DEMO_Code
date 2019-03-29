//
//  MoudleTarget_B.m
//  compoent
//
//  Created by closureJan on 2019/3/29.
//  Copyright © 2019年 jian.yang. All rights reserved.
//

#import "MoudleTatget_B.h"
#import "MoudleB_homeController.h"
typedef void (^CTUrlRouterCallbackBlock)(NSDictionary *info);

@implementation MoudleTatget_B



-(UIViewController *)MoudleTatget_loadController:(NSDictionary *)parmars
{
    CTUrlRouterCallbackBlock block = parmars[@"block"];
    MoudleB_homeController *b_homeVC = [[MoudleB_homeController alloc]initWithCompleteBlock:block];
    return b_homeVC;
}

@end
