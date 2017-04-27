//
//  ApiManager.h
//  TutorialEleven
//
//  Created by iOS-School-1 on 27.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AFNetworking;


@interface ApiManager : NSObject <UIWebViewDelegate>

+ (id)sharedManager;
-(void)getContacts;
-(void)getAuthorization:(UIViewController *)currentVC;
@end
