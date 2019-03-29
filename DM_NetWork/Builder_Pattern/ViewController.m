//
//  ViewController.m
//  Builder_Pattern
//
//  Created by mingxin.ji on 2019/3/27.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import "ViewController.h"
#import "DMNetWorkCache.h"
#import "DMAPIRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
//    NSSet * muSet = [[NSSet alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
//    [muSet enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
//
//        NSLog(@"%@===%p",obj,obj);
//    }];
//
//    NSLog(@"muset===%p",muSet);
    
    DMAPIRequest * request = [[DMAPIRequest alloc]init];
    request.responseObject = [self convertToJsonData:@{@"name":@"jianyang"}];
    [DMNetWorkCache saveCacheDataWithRequest:request];
    [DMNetWorkCache loadCacheDataWithRequest:request];
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
