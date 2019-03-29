//
//  LogInViewModel.h
//  ReactiveCocoa-MVVM
//
//  Created by mingxin.ji on 2019/3/13.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface Account : NSObject

@property(nonatomic, copy)NSString *account;
@property(nonatomic, copy)NSString *pwd;

@end

@interface LogInViewModel : NSObject

@property(nonatomic, strong)Account *account;

// 是否允许登录的信号
@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;

@property (nonatomic, strong, readonly) RACCommand *LoginCommand;

@end
