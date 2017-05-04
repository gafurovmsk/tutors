//
//  LoginViewController.m
//  TutorialEleven
//
//  Created by iOS-School-1 on 02.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "LoginViewController.h"
#import "ListViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <VKSdkFramework/VKSdkFramework.h>
#import "Contact.h"
@import Masonry;


@interface LoginViewController () <FBSDKLoginButtonDelegate,VKSdkDelegate>
//@property FBSDKAccessToken *token;
@property (nonatomic,strong)NSArray<Contact*> *list;

@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  //FB button
  FBSDKLoginButton *fbLoginButton = [[FBSDKLoginButton alloc] init];
  fbLoginButton.readPermissions = @[@"public_profile", @"email", @"user_friends",@"read_custom_friendlists"];
  fbLoginButton.delegate = self;
  [self.view addSubview:fbLoginButton];
  [fbLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
  }];
  
  //VK button
  UIButton *vkLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
  vkLoginButton.titleLabel.text = @"Вход во вконтакте";
  vkLoginButton.backgroundColor = [UIColor redColor];
  [self.view addSubview:vkLoginButton];
  [vkLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.view);
    make.top.equalTo(fbLoginButton.mas_bottom).with.offset(8);
    make.height.equalTo(fbLoginButton.mas_height);
    make.width.equalTo(fbLoginButton.mas_width);
  
  }];

  
  
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
  
  
  
}
-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
  
  // как обойтись без выхода-входа (лишних шагов при входе)
  
  // нужно ли его здесь задавать
  ListViewController *listVC = [ListViewController new];
  
  
  
  FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                initWithGraphPath:@"me/taggable_friends?fields=id,name,picture.type(large)"
                                parameters:nil
                                HTTPMethod:@"GET"];
  [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                        id result,
                                        NSError *error) {
    
    if(error) NSLog(@"Error: %@",error.description);
    else {
      NSLog(@"Succesfull downloading friends list");
      NSArray *list = [result valueForKey:@"data"];
      [self fetchFriendsInfo:list];
      
      [listVC addContacts:self.list];
      [self.navigationController pushViewController:listVC animated:YES];
    }
  }];
}

-(void)fetchFriendsInfo:(NSArray*)list {
  
  NSMutableArray <Contact *> *mutableList = [NSMutableArray new];
  
  for (id item in list) {
    
    NSString *imageURL = [[[item valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    // NSString *jsonString = [[NSString alloc] initWithData:item encoding:NSUTF8StringEncoding];
    
    NSArray *fullname = [[item valueForKey:@"name"] componentsSeparatedByString:@" "];
    Contact *friend = [[Contact alloc]initWithImage:imageData andFirst:fullname[0] andLastName:fullname[1]];
    [mutableList addObject:friend];
  }
  
  self.list = mutableList;
}

-(void)vkSdkUserAuthorizationFailed{
  
}
-(void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
  
  NSArray *SCOPE = @[@"friends", @"email"];
  
  //VKRequest *request = [VKRequest wi]
  
  
}

@end
