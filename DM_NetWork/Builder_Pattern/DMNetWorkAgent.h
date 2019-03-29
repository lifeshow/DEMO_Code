//
//  DMNetWorkAgent.h
//  Builder_Pattern
//
//  Created by mingxin.ji on 2019/3/27.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMBaseRequest.h"
@interface DMNetWorkAgent : NSObject

+ (instancetype)shareAgent;


- (void)addRequest: (DMBaseRequest *)request;


- (void)cancelRequest: (DMBaseRequest *)request;

@end
