//
//  HomeController.m
//  ReactiveCocoa-MVVM
//
//  Created by mingxin.ji on 2019/3/13.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import "HomeController.h"
#import <ReactiveCocoa.h>
#import "RequestViewModel.h"

@interface HomeController ()

@property(nonatomic, strong)RequestViewModel *requestViewModel;


@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    RACSignal *sign = [self.requestViewModel.requestCommand execute:nil];
    
    [sign subscribeNext:^(id x) {
        
    }];
    
}

-(RequestViewModel *)requestViewModel
{
    if (!_requestViewModel)
    {
        _requestViewModel = [RequestViewModel new];
    }
    
    return _requestViewModel;
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
