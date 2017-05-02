//
//  LoginViewController.m
//  TutorialEleven
//
//  Created by iOS-School-1 on 02.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@import Masonry;


@interface LoginViewController () <FBSDKLoginButtonDelegate>
@property FBSDKAccessToken *token;
@end

@implementation LoginViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends",@"read_custom_friendlists"];
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
    
    
}
-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    
    self.token = result.token;
    
    self.token
    
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/{friend-list-id}"
                                  parameters:nil
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        NSLog(@"%@",result);
    }];
}


@end
