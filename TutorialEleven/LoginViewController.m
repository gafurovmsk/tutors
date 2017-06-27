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
@property (nonatomic,strong)NSString *responseVK;
@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  //FB button
  UIView *containerForFBSDKLoginButton = [UIView new];
  
  FBSDKLoginButton *fbLoginButton = [[FBSDKLoginButton alloc] init];
  fbLoginButton.readPermissions = @[@"public_profile", @"email", @"user_friends",@"read_custom_friendlists"];
  fbLoginButton.delegate = self;
  [fbLoginButton setTitle:@"" forState:UIControlStateNormal];
  
  [containerForFBSDKLoginButton addSubview:fbLoginButton];
  [fbLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(containerForFBSDKLoginButton);
    make.centerX.equalTo(containerForFBSDKLoginButton).with.offset(-10);
    make.width.equalTo(fbLoginButton.mas_height);
  }];
  
  UIBarButtonItem *fbItem = [[UIBarButtonItem alloc]initWithCustomView:containerForFBSDKLoginButton];
  
  
  //VK button
  UIView *containerForVKLoginButton = [UIView new];
  UIButton *vkLoginButton = [UIButton new];
  vkLoginButton.titleLabel.text = @"";
  [vkLoginButton setBackgroundImage:[UIImage imageNamed:@"vk.png"] forState:UIControlStateNormal];
  [containerForVKLoginButton addSubview:vkLoginButton];
  [vkLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(containerForVKLoginButton);
    make.centerX.equalTo(containerForVKLoginButton).with.offset(-40);
    make.height.width.equalTo(@28);
    }];
  UIBarButtonItem *vkItem = [[UIBarButtonItem alloc]initWithCustomView:containerForVKLoginButton];
  
  SCOPE = @[VK_PER_FRIENDS];
  [[VKSdk initializeWithAppId:@"6006342"] registerDelegate:self];
  [[VKSdk instance] setUiDelegate:self];
  [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
    if (state == VKAuthorizationAuthorized) {
      [self startWorking];
    } else if (error) {
      [[[UIAlertView alloc] initWithTitle:nil message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
  }];
  self.navigationItem.rightBarButtonItems =@[fbItem, vkItem];

  [vkLoginButton addTarget:containerForVKLoginButton action:@selector(vkButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
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
  VKRequest *friendsListRequest = [[VKApi friends] get:@{@"fields":@"first_name,last_name,city,contacts"}];
  
  __weak __typeof(self) welf = self;
  [friendsListRequest executeWithResultBlock:^(VKResponse *response) {
    welf.responseVK = [NSString stringWithFormat:@"Result: %@", response];
    NSLog(@"%@", response.request.requestTiming);
  }                                errorBlock:^(NSError *error) {
    welf.responseVK = [NSString stringWithFormat:@"Error: %@", error];
  }];
}

- (void)vkSdkWillDismissViewController:(UIViewController *)controller{
  
}
@end
