//
//  DMNetWorkCache.h
//  Builder_Pattern
//
//  Created by mingxin.ji on 2019/3/28.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DMBaseRequest;

@interface DMNetWorkCache : NSObject

+(void)saveCacheDataWithRequest: (DMBaseRequest *)request;

+(void)loadCacheDataWithRequest: (DMBaseRequest *)request;

@end
