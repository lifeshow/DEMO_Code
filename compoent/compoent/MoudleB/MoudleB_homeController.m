//
//  MoudleB_homeController.m
//  compoent
//
//  Created by closureJan on 2019/3/29.
//  Copyright © 2019年 jian.yang. All rights reserved.
//

#import "MoudleB_homeController.h"

@interface MoudleB_homeController ()

@property(nonatomic, copy)void(^completeBlock)(NSDictionary *);

@end

@implementation MoudleB_homeController

-(instancetype)initWithCompleteBlock:(void (^)(NSDictionary *))block
{
    if (self = [super init])
    {
        self.completeBlock = block;
    }
    
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.completeBlock(@{@"name":@"jian"});
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"moudle_B";
    self.view.backgroundColor = [UIColor purpleColor];
    // Do any additional setup after loading the view.
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
