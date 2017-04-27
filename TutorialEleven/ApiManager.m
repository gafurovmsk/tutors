//
//  ApiManager.m
//  TutorialEleven
//
//  Created by iOS-School-1 on 27.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ApiManager.h"

@implementation ApiManager 

+ (id)sharedManager {
    static ApiManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}



-(void)getContacts {
    
    

}

-(void)getAuthorization:(UIViewController *)currentVC{
    
    UIWebView *webView = [UIWebView new];
    UIViewController *webVC = [UIViewController new];
    webVC.view = webView;
    
    [currentVC presentViewController:webVC animated:YES completion:nil];
    

}





@end
