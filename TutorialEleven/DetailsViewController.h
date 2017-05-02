//
//  DetailsViewController.h
//  TutorialEleven
//
//  Created by Nik on 01.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
@interface DetailsViewController : UIViewController

@property Contact *showedContact;

- (instancetype)initWithTitle:(NSString *)title andContact:(Contact *)contact;

@end
