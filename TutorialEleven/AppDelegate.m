//
//  AppDelegate.m
//  TutorialEleven
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AppDelegate.h"
//#import "ListViewController.h"
#import "TELoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <VKSdkFramework/VKSdkFramework.h>
@import UIKit;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  [[FBSDKApplicationDelegate sharedInstance]
    application:application didFinishLaunchingWithOptions:launchOptions];
  [VKSdk initializeWithAppId:@"6006342"];
  
  UIWindow *window = [UIWindow new];
  UIViewController *startVC = [TELoginViewController new];
  UINavigationController *navigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:startVC];
  window.rootViewController = navigationController;
  self.window = window ;
  [self.window makeKeyAndVisible];

  return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
    options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
  
  BOOL handled = [[FBSDKApplicationDelegate sharedInstance]
                   application:application
                   openURL:url
                   sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                   annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
  
  [VKSdk processOpenURL:url fromApplication:UIApplicationOpenURLOptionsSourceApplicationKey];
  
  return handled;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [FBSDKAppEvents activateApp];
}

@end
