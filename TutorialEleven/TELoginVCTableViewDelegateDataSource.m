//
//  TELoginVCTableViewDelegateDataSource.m
//  TutorialEleven
//
//  Created by Nik on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "TELoginVCTableViewDelegateDataSource.h"
#import "Contact.h"
#import "ContactCell.h"
#import "DetailsViewController.h"
#import "TELoginViewController.h"
#import "CColorDictionary.h"

static NSString *const TEContactCellID = @"cellID";

@interface TELoginVCTableViewDelegateDataSource ()

@property (weak,readonly,nonatomic) TELoginViewController *controller;

@end

@implementation TELoginVCTableViewDelegateDataSource

-(instancetype)initWithController:(TELoginViewController *)controller {
  self = [super init];
  if(self) {
    _controller = controller;
  }
  return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.controller.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  ContactCell *customCell = [tableView dequeueReusableCellWithIdentifier:TEContactCellID];
  customCell.firstNameLabel.text = self.controller.list[indexPath.row].firstName;
  customCell.secondNameLabel.text = self.controller.list[indexPath.row].secondName;
  
  if (!self.controller.list[indexPath.row].contactImageData) {
    customCell.contactImage.backgroundColor = [CColorDictionary generateColorWithString:self.controller.list[indexPath.row].imageSymbols];
    customCell.imageSymbolsLabel.text = self.controller.list[indexPath.row].imageSymbols;
  } else {
    customCell.contactImage.image = [UIImage imageWithData:self.controller.list[indexPath.row].contactImageData];
  }
  return customCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  NSString *title = self.controller.list[indexPath.row].firstName;
  DetailsViewController *detailsVC = [[DetailsViewController alloc]
                                      initWithTitle:title andContact: self.controller.list[indexPath.row]];
  [self.controller.navigationController pushViewController:detailsVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return [ContactCell heightForCell];
}

@end
