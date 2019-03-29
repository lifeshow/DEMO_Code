//
//  ViewController.m
//  ReactiveCocoa-MVVM
//
//  Created by mingxin.ji on 2019/3/13.
//  Copyright © 2019 jian.yang. All rights reserved.
//

#import "LogInController.h"
#import <ReactiveCocoa.h>
#import <UIView+SDAutoLayout.h>
#import "LogInViewModel.h"
#import "HomeController.h"

@interface LogInController ()

@property(nonatomic, strong)UITextField *accountTF;

@property(nonatomic, strong)UITextField *pwdTF;

@property(nonatomic, strong)UIButton *logoInButton;

@property(nonatomic, strong)LogInViewModel *loginViewModel;

@end

@implementation LogInController



#pragma mark -life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"登录";
    
    [self.view addSubview:self.accountTF];
    [self.view addSubview:self.pwdTF];
    [self.view addSubview:self.logoInButton];
    
    [self layoutPageSubviews];
    [self bindViewModel];
}

- (void)layoutPageSubviews
{
    self.accountTF.sd_layout
    .leftSpaceToView(self.view, 20)
    .rightSpaceToView(self.view, 20)
    .topSpaceToView(self.view, 40+64)
    .heightIs(44);
    
    self.pwdTF.sd_layout
    .leftSpaceToView(self.view, 20)
    .rightSpaceToView(self.view, 20)
    .topSpaceToView(self.accountTF, 20)
    .heightIs(44);
    
    self.logoInButton.sd_layout
    .leftEqualToView(self.accountTF)
    .rightEqualToView(self.accountTF)
    .topSpaceToView(self.pwdTF, 40)
    .heightIs(44);
    
    [[self.logoInButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        // 执行登录事件
        [self.loginViewModel.LoginCommand execute:nil];
    }];
}

#pragma mark -Delegate

#pragma mark -event response

#pragma mark -private methods
-(void)bindViewModel
{
    RAC(self.loginViewModel.account, account) = _accountTF.rac_textSignal;
    RAC(self.loginViewModel.account,pwd) = _pwdTF.rac_textSignal;
    
    RAC(self.logoInButton,enabled) = self.loginViewModel.enableLoginSignal;
    

    
      //监听产生的数据
  
    [self.loginViewModel.LoginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        
        if ([x isEqualToString:@"登录成功"])
        {
            HomeController *homeVC = [HomeController new];
            [self.navigationController pushViewController:homeVC animated:YES];
        }
    }];
    
    
    
}
#pragma mark -getters and setters

-(UITextField *)accountTF
{
    if (!_accountTF )
    {
        _accountTF = [[UITextField alloc]init];
        _accountTF.borderStyle = UITextBorderStyleLine;
        _accountTF.font = [UIFont systemFontOfSize:14];
        _accountTF.textColor = [UIColor blackColor];
    }
    
    return _accountTF;
}

-(UITextField *)pwdTF
{
    if (!_pwdTF)
    {
        _pwdTF = [[UITextField alloc]init];
        _pwdTF.borderStyle = UITextBorderStyleLine;
        _pwdTF.font = [UIFont systemFontOfSize:14];
        _pwdTF.secureTextEntry = YES;
        _pwdTF.textColor = [UIColor blackColor];
    }
    
    return _pwdTF;
}

-(UIButton *)logoInButton
{
    if (!_logoInButton)
    {
        _logoInButton = [[UIButton alloc]init];
        [_logoInButton setTitle:@"登录" forState:UIControlStateNormal];
        
        _logoInButton.enabled = NO;
        [_logoInButton setBackgroundImage:[self createImageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        [_logoInButton setBackgroundImage:[self createImageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
    }
    
    return _logoInButton;
}

-(LogInViewModel *)loginViewModel
{
    if (!_loginViewModel)
    {
        _loginViewModel = [LogInViewModel new];
    }
    
    return _loginViewModel;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
