//
//  DetailsViewController.m
//  TutorialEleven
//
//  Created by Nik on 01.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailsView.h"
#import "Contact.h"
@import Masonry;

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (instancetype)initWithTitle:(NSString *)title andContact:(Contact *)contact {
  self = [super init];
  if (!self) return nil;
  _showedContact = contact;
  self.title = title;
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  DetailsView *view = [DetailsView new];
  [self.view addSubview:view];
  
  [view mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.view);
  }];
  
  [view addContactWithName:self.showedContact.firstName
    andSecond:self.showedContact.secondName andImage:self.showedContact.contactImageData];
  
}

@end
