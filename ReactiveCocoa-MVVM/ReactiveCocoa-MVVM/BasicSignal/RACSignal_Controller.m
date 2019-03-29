//
//  RACSignal_Controller.m
//  ReactiveCocoa-MVVM
//
//  Created by mingxin.ji on 2019/3/13.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import "RACSignal_Controller.h"
#import <ReactiveCocoa.h>

@interface RACSignal_Controller ()
{
    RACCommand *_command;
}
@end

@implementation RACSignal_Controller

- (void)viewDidLoad {
    [super viewDidLoad];



}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    RACSignal * sign =  [_command execute:@"ddfwegferg"];
    
    [sign subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
}

-(void)initRACSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSLog(@"创建信号量");
        
        //发布新
        [subscriber sendNext:@"I'm send next data"];
        
        NSLog(@"那我啥时候运行");
        
        return [RACDisposable disposableWithBlock:^{
            
            NSLog(@"disposable");
            
        }];
    }];
    
    //2.订阅信号量
    RACDisposable *dispossable = [signal subscribeNext:^(id x) {
        
        NSLog(@"====%@",x);
        
    }];
    
    
    [dispossable dispose];
}

-(void)initSubSign
{
    
    //创建信号量
    RACSubject *subject = [RACSubject subject];
    
    
    [subject subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
        
        
    }];
    
    [subject subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    
    //发送数据
    [subject sendNext:@"发送数据"];
    
    [subject sendNext:@"发送绅士手"];
}

-(void)initCommand
{
    RACCommand * command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        NSLog(@"input=====%@",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            [subscriber sendNext:@"sssssssssss"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                
                NSLog(@"消失了");
            }];
        }];
    }];
    
    _command = command;
    //    [_command.executionSignals subscribeNext:^(id x) {
    //
    //        [x subscribeNext:^(id x) {
    //
    //            NSLog(@"==%@",x);
    //
    //        }];
    //
    //    }];
    
    
    
    [_command.executionSignals.switchToLatest subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
        
    }];
    
    [[_command.executing skip:0] subscribeNext:^(id x) {
        
        if ([x boolValue])
        {
            NSLog(@"还在执行");
        }else
        {
            NSLog(@"执行结束了");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
