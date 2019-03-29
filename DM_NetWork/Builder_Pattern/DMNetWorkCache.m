//
//  DMNetWorkCache.m
//  Builder_Pattern
//
//  Created by mingxin.ji on 2019/3/28.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import "DMNetWorkCache.h"
#import "DMBaseRequest.h"
#import <CommonCrypto/CommonDigest.h>
@implementation DMNetWorkCache

+ (NSString *)md5StringFromString:(NSString *)string {
    NSParameterAssert(string != nil && [string length] > 0);
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }
    
    return outputString;
}


+(void)saveCacheDataWithRequest: (DMBaseRequest *)request
{
    NSString * requestInfo = [NSString stringWithFormat:@"method:%@,baseUrl:%@,requestUrl:%@,argument:%@",@([request requestMethod]),[request baseUrl],[request requestUrl],[request requestParameters]];
    NSString *cacheFileName = [self md5StringFromString:requestInfo];
    
    NSString * path = [[self cacheBasePath]stringByAppendingPathComponent:cacheFileName];
    [request.responseObject writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}



+(void)loadCacheDataWithRequest: (DMBaseRequest *)request
{
    NSString * requestInfo = [NSString stringWithFormat:@"method:%@,baseUrl:%@,requestUrl:%@,argument:%@",@([request requestMethod]),[request baseUrl],[request requestUrl],[request requestParameters]];
    NSString *cacheFileName = [self md5StringFromString:requestInfo];
    
    NSString * path = [[self cacheBasePath]stringByAppendingPathComponent:cacheFileName];
    
      NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path isDirectory:nil])
    {
       NSData *  data = [NSData dataWithContentsOfFile:path];
        NSString * result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        request.responseObject = result;
    }
}

+ (NSString *)cacheBasePath
{
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"LazyRequestCache"];
    [self createDirectoryIfNeeded:path];
    
    return path;
}

+ (void)createDirectoryIfNeeded:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                                   attributes:nil error:nil];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                                       attributes:nil error:nil];
        }
    }
}
@end
