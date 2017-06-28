//
//  LoginViewController.h
//  TutorialEleven
//
//  Created by iOS-School-1 on 02.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;

@interface TELoginViewController : UIViewController 
@property (strong,nonatomic) NSMutableArray<Contact*> *list;
@end
