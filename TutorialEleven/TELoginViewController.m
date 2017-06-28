//
//  LoginViewController.m
//  TutorialEleven
//
//  Created by iOS-School-1 on 02.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "TELoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <VKSdkFramework/VKSdkFramework.h>
#import "TELoginVCTableViewDelegateDataSource.h"
#import "ContactCell.h"
#import "Contact.h"
@import Masonry;

static NSArray *SCOPE = nil;
static NSString *const TEContactCellID = @"cellID";

@interface TELoginViewController () <FBSDKLoginButtonDelegate,VKSdkDelegate,VKSdkUIDelegate>


@property (strong,nonatomic) NSString *responseVK;
@property (strong,nonatomic) UITableView *contactTable;
@property (strong,nonatomic) TELoginVCTableViewDelegateDataSource *tableViewService;
//@property (nonatomic,strong) NSArray<Contact*> *list;

@end

@implementation TELoginViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"Contacts";
  self.view.backgroundColor = [UIColor whiteColor];
  
  //FB button
  FBSDKLoginButton *fbLoginButton = [[FBSDKLoginButton alloc] init];
  fbLoginButton.readPermissions = @[@"public_profile",
                                    @"email",
                                    @"user_friends",
                                    @"read_custom_friendlists"];
  fbLoginButton.delegate = self;
  [fbLoginButton mas_makeConstraints:^(MASConstraintMaker *make){
      make.width.equalTo(fbLoginButton.mas_height);
  }];
  
  //VK button
  UIButton *vkLoginButton = [UIButton new];
  [vkLoginButton setBackgroundImage:[UIImage imageNamed:@"vk.png"]
    forState:UIControlStateNormal];
  [vkLoginButton mas_makeConstraints:^(MASConstraintMaker *make){
    make.height.width.equalTo(@29);
  }];
  [vkLoginButton addTarget:self action:@selector(vkButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
#pragma mark - vk sdk needs
  SCOPE = @[VK_PER_FRIENDS];
  [[VKSdk initializeWithAppId:@"6006342"] registerDelegate:self];
  [[VKSdk instance] setUiDelegate:self];
  // loading without wait
  [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
    if (state == VKAuthorizationAuthorized) {
      [self startWorking];
    } else if (error) {
      [[[UIAlertView alloc] initWithTitle:nil message:[error description]
        delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
  }];
  
  // Adding UIBarButton
  UIBarButtonItem *vkBarItem = [[UIBarButtonItem alloc]initWithCustomView:vkLoginButton];
  UIBarButtonItem *fbBarItem = [[UIBarButtonItem alloc]initWithCustomView:fbLoginButton];
  self.navigationItem.rightBarButtonItems =@[fbBarItem, vkBarItem];
  
#pragma mark - Tableview
  
  UIEdgeInsets edgesInsets =  UIEdgeInsetsMake(4, 4, -4, -4);
  
  self.contactTable = [UITableView new];
  [self.view addSubview:self.contactTable];
  
  [self.contactTable mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.view).with.insets(edgesInsets);
  }];
  
  [self.contactTable registerClass: ContactCell.self forCellReuseIdentifier:TEContactCellID];
  self.tableViewService = [[TELoginVCTableViewDelegateDataSource alloc]initWithController:self];
  self.contactTable.delegate = _tableViewService;
  self.contactTable.dataSource = _tableViewService;

}


#pragma mark - fb SDK
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
  NSLog(@"Logut is successful!");
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {  
  FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                initWithGraphPath:@"me/taggable_friends?fields=id,name,picture.type(large)"
                                parameters:nil
                                HTTPMethod:@"GET"];
  [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                        id result, NSError *error) {
    if (error) {
      NSLog(@"Error: %@",error.description);
    } else {
      NSLog(@"Succesfull downloading friends list");
      NSArray *list = [result valueForKey:@"data"];
      [self fetchFBFriendsInfo:list];
      [self.contactTable reloadData];
    }
  }];
}

- (void)fetchFBFriendsInfo:(NSArray*)list {
  
  NSMutableArray <Contact *> *mutableList = [NSMutableArray new];
  
  for (id item in list) {
    
    NSString *imageURL = [[[item valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
  
    NSArray *fullname = [[item valueForKey:@"name"] componentsSeparatedByString:@" "];
    Contact *friend = [[Contact alloc]initWithImage:imageData andFirst:fullname[0] andLastName:fullname[1]];
    [mutableList addObject:friend];
  }
  
  if (!self.list) {
    self.list = mutableList;
  } else {
    [self.list addObjectsFromArray:mutableList];
  }
}

#pragma mark - vk SDK
- (void)vkButtonPressed{
  [VKSdk authorize:SCOPE];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
  [self.navigationController.topViewController presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkUserAuthorizationFailed{
   [[[UIAlertView alloc] initWithTitle:nil message: @"Access denied!\n Smth goes wrong!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}
- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
  if (result.token) {
    [self startWorking];
  } else if (result.error) {
    [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Access denied\n%@", result.error] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    
  }
}

- (void)startWorking{
  VKRequest *friendsListRequest = [[VKApi friends] get:@{@"fields":@"first_name,last_name,city,contacts,photo_200_orig"}];
  
  __weak __typeof(self) welf = self;
  [friendsListRequest executeWithResultBlock:^(VKResponse *response) {
    [welf fetchVKFriendsInfo:[response.json valueForKey:@"items"]];
    [self.contactTable reloadData];
  }                                errorBlock:^(NSError *error) {
    welf.responseVK = [NSString stringWithFormat:@"Error: %@", error];
  }];
}

- (void)fetchVKFriendsInfo:(NSArray *)list {
  
  NSMutableArray <Contact *> *mutableList = [NSMutableArray new];
  
  for (id item in list) {
    
    NSString *imageURL = [item valueForKey:@"photo_200_orig"] ;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    NSString *firstName = [item valueForKey:@"first_name"];
    NSString *lastName = [item valueForKey:@"last_name"];
    //NSString *phone = [item valueForKey:@"mobile_phone"];
    Contact *friend = [[Contact alloc]initWithImage:imageData andFirst:firstName andLastName:lastName];
    [mutableList addObject:friend];
  }
  if (!self.list) {
    self.list = mutableList;
  } else {
    [self.list addObjectsFromArray:mutableList];
  }
}

@end
