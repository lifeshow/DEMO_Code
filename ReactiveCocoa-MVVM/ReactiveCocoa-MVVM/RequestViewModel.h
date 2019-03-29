//
//  RequestViewModel.h
//  ReactiveCocoa-MVVM
//
//  Created by mingxin.ji on 2019/3/13.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface RequestViewModel : NSObject

@property(nonatomic, strong,readonly)RACCommand *requestCommand;

@property(nonatomic, strong, readonly)NSArray *models;


@end
