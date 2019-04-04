//
//  ViewController.m
//  RSA公私钥
//
//  Created by mingxin.ji on 2019/4/4.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import "ViewController.h"
#import "RYTRSAEncryptor.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RYTRSAEncryptor keyWith:^(NSString *pubKey, NSString *priKey) {
       
        NSLog(@"==%@\n==%@",pubKey,priKey);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
