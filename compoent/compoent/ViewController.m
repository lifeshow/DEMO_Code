//
//  ViewController.m
//  compoent
//
//  Created by closureJan on 2019/3/29.
//  Copyright © 2019年 jian.yang. All rights reserved.
//

#import "ViewController.h"
#import "Mediator.h"
#import "Mediator+MoudleTarget_A.h"
#import "Mediator+MoudleTarger_B.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIButton *moudleA_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [moudleA_Button setTitle:@"moudleA" forState:UIControlStateNormal];
    [moudleA_Button setBackgroundColor:[UIColor redColor]];
    [moudleA_Button addTarget:self action:@selector(moudleAClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moudleA_Button];
    moudleA_Button.frame = CGRectMake(20, 84, self.view.frame.size.width - 40, 50);
    
    UIButton *moudleB_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [moudleB_Button setTitle:@"moudleA" forState:UIControlStateNormal];
    [moudleB_Button setBackgroundColor:[UIColor redColor]];
    [moudleB_Button addTarget:self action:@selector(moudleBClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moudleB_Button];
    moudleB_Button.frame = CGRectMake(20, 84+70, self.view.frame.size.width - 40, 50);
}


-(void)moudleAClick
{
    UIViewController *controler = [[Mediator shareInstance]gotToMoudleAController];
    [self.navigationController pushViewController:controler animated:YES];
}


-(void)moudleBClick
{
    UIViewController *controller = [[Mediator shareInstance]gotoMoudleBControlerCompleteBlock:^(NSDictionary *info) {
        NSLog(@"==%@",info);
    }];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
