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

static NSArray *SCOPE = nil;

@interface LoginViewController () <FBSDKLoginButtonDelegate,VKSdkDelegate,VKSdkUIDelegate>

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
  SCOPE = @[VK_PER_FRIENDS];
  [[VKSdk initializeWithAppId:@"6006342"] registerDelegate:self];
  [[VKSdk instance] setUiDelegate:self];
 // [[VKSdk instance] registerDelegate:self];
  
  
  UIButton *vkLoginButton = [UIButton new];
  vkLoginButton.titleLabel.text = @"Вход vk";
  vkLoginButton.tintColor = [UIColor blackColor];
  vkLoginButton.imageView.image = [UIImage imageNamed:@"vk.png"];
  vkLoginButton.backgroundColor = [UIColor greenColor];
  [self.view addSubview:vkLoginButton];
  [vkLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.view);
    make.top.equalTo(fbLoginButton.mas_bottom).with.offset(8);
    make.height.equalTo(fbLoginButton.mas_height);
    make.width.equalTo(fbLoginButton.mas_width);
  
  }];
  
  //special functions
  [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
    if (state == VKAuthorizationAuthorized) {
      [self startWorking];
    } else if (error) {
      [[[UIAlertView alloc] initWithTitle:nil message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
  }];


  [vkLoginButton addTarget:self action:@selector(vkButtonPressed) forControlEvents:UIControlEventTouchUpInside];

}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
  
}
- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
  
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
      NSMutableArray *list = [result valueForKey:@"data"];
      [self fetchFriendsInfo:list];
      
      [listVC addContacts:self.list];
      [self.navigationController pushViewController:listVC animated:YES];
    }
  }];
}

- (void)fetchFriendsInfo:(NSArray*)list {
  
  NSMutableArray <Contact *> *mutableList = [NSMutableArray new];
  
  for (id item in list) {
    
    NSString *imageURL = [[[item valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
  
    NSArray *fullname = [[item valueForKey:@"name"] componentsSeparatedByString:@" "];
    Contact *friend = [[Contact alloc]initWithImage:imageData andFirst:fullname[0] andLastName:fullname[1]];
    [mutableList addObject:friend];
  }
  self.list = mutableList;
}

- (void)vkButtonPressed{
  [VKSdk authorize:SCOPE];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
  [self.navigationController.topViewController presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkUserAuthorizationFailed{
  
}
- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
  if (result.token) {
    [self startWorking];
  } else if (result.error) {
    [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Access denied\n%@", result.error] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    
  }
}

- (void)startWorking{
  VKRequest *friendsList = [[VKApi friends]get];
  
  
  
}


- (void)vkSdkWillDismissViewController:(UIViewController *)controller{
  
}

@end
