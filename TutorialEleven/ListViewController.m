//
//  ViewController.m
//  TutorialEleven
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ListViewController.h"
#import "Contact.h"
#import "QuartzCore/CALayer.h"
#import "ContactCell.h"
#import "ApiManager.h"
#import "DetailsViewController.h"
#import "DetailsView.h"

@import Masonry;

//const NSString *cellId = @"cellId";
NSString *const contactCellId = @"cellID";

@interface ListViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *contactTable;
@property (nonatomic,strong) NSArray<Contact*> *list;
@property (nonatomic,strong) ApiManager *sharedManager;

@end

@implementation ListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.sharedManager = [ApiManager sharedManager];
  
  //    [self.sharedManager getAuthorization];
  //
  //    self.list = [self.sharedManager  getContacts];
  
  UIEdgeInsets edgesInsets =  UIEdgeInsetsMake(0, 8, 8, 8);
  
  self.contactTable = [UITableView new];
  [self.view addSubview:self.contactTable];
  
  [self.contactTable mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.view).with.insets(edgesInsets);
  }];
  
  
  self.list = @[
                [[Contact alloc]initWithFirstName:@"Alan" andSecondName:@"Kay"],
                [[Contact alloc]initWithFirstName:@"Bjarne " andSecondName:@"Stroustrup"],
                [[Contact alloc]initWithFirstName:@"Flop " andSecondName:@"Job"],
                [[Contact alloc]initWithFirstName:@"Isaak " andSecondName:@"Burber"],
                [[Contact alloc]initWithFirstName:@"Claud " andSecondName:@"Mane"],
                [[Contact alloc]initWithFirstName:@"Mike " andSecondName:@"Buanorotti"],
                [[Contact alloc]initWithFirstName:@"Glower " andSecondName:@"Jobber"],
                [[Contact alloc]initWithFirstName:@"Erich" andSecondName:@"Gamma"]
                ];
  
  self.view.backgroundColor = [UIColor magentaColor];
  
  [self.contactTable registerClass: ContactCell.self forCellReuseIdentifier:contactCellId];
  
  self.contactTable.delegate = self;
  self.contactTable.dataSource = self;
  
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  ContactCell *customCell = [tableView dequeueReusableCellWithIdentifier:contactCellId];
  [customCell addContact:self.list[indexPath.row]];
  // обращаться напрямую это нарушение ООП. лучше послать сообщением.
  //  customCell.nameLabel.text = self.list[indexPath.row].firstName;
  //  customCell.imageSymbolsLabel.text = self.list[indexPath.row].firstSymbols;
  
  // нужна ли эта проверка ?
  if (customCell == nil) {
    customCell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contactCellId];
  }

  return customCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  NSString *title = self.list[indexPath.row].firstName;
  DetailsViewController *detailsVC = [[DetailsViewController alloc]initWithTitle:title
                                                                      andContact: self.list[indexPath.row]];
  [self.navigationController pushViewController:detailsVC animated:YES];
  
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//  return [ContactCell heightForCell];
//}
@end
