//
//  DetailsViewController.m
//  TutorialEleven
//
//  Created by Nik on 01.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailsView.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (instancetype)initWithTitle:(NSString *)title andContact:(Contact *)contact {
  self = [super init];
  if (!self) return nil;
  _showedContact = contact;
  self.title = title;
  DetailsView * view = [DetailsView new];
  
  if(_showedContact != nil) {
    [view addThisContact:_showedContact];
     self.view = view;
  }
  
 
  
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
