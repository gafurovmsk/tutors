//
//  ViewController.m
//  TutorialEleven
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ListViewController.h"
#import "DetailsViewController.h"

#import "Contact.h"
#import "ContactCell.h"
#import "ApiManager.h"
#import "CColorDictionary.h"

#import "DetailsView.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


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
  //    self.list = [self.sharedManager  getContacts];
  
  
  //FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
  // UIBarButtonItem *facebookItem = [[UIBarButtonItem alloc]initWithCustomView:loginButton];
  
  UIBarButtonItem *testitem = [[UIBarButtonItem alloc]initWithTitle:@"TEST" style:UIBarButtonItemStyleDone target:nil action:nil];
  [self.navigationController.navigationItem setRightBarButtonItem:testitem];
  
  
  UIEdgeInsets edgesInsets =  UIEdgeInsetsMake(4, 4, 4, 4);
  
  self.contactTable = [UITableView new];
  [self.view addSubview:self.contactTable];
  
  [self.contactTable mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.view).with.insets(edgesInsets);
  }];
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self.contactTable registerClass: ContactCell.self forCellReuseIdentifier:contactCellId];
  
  self.contactTable.delegate = self;
  self.contactTable.dataSource = self;
  
}

-(void)addContacts:(NSMutableArray *)list{
  
  self.list = list;
  
  [self.contactTable reloadData];
  
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  ContactCell *customCell = [tableView dequeueReusableCellWithIdentifier:contactCellId];
  // обращаться напрямую это НЕ нарушение ООП
  customCell.firstNameLabel.text = self.list[indexPath.row].firstName;
  customCell.secondNameLabel.text = self.list[indexPath.row].secondName;
  
  if (!self.list[indexPath.row].contactImageData) {
    customCell.contactImage.backgroundColor = [CColorDictionary generateColorWithString:self.list[indexPath.row].imageSymbols];
    customCell.imageSymbolsLabel.text = self.list[indexPath.row].imageSymbols;
  } else {
    customCell.contactImage.image = [UIImage imageWithData:self.list[indexPath.row].contactImageData];
  }
  
  
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return [ContactCell heightForCell];
}


-(void)viewDidAppear:(BOOL)animated {
  
  [super viewDidAppear:animated];
  
  [self.contactTable reloadData];
  
}

@end





//    self.list = @[
//                  [[Contact alloc]initWithFirstName:@"Alan" andSecondName:@"Kay"],
//                  [[Contact alloc]initWithFirstName:@"Bjarne " andSecondName:@"Stroustrup"],
//                  [[Contact alloc]initWithFirstName:@"Flop " andSecondName:@"Job"],
//                  [[Contact alloc]initWithFirstName:@"Isaak " andSecondName:@"Burber"],
//                  [[Contact alloc]initWithFirstName:@"Claud " andSecondName:@"Mane"],
//                  [[Contact alloc]initWithFirstName:@"Mike " andSecondName:@"Buanorotti"],
//                  [[Contact alloc]initWithFirstName:@"Glower " andSecondName:@"Jobber"],
//                  [[Contact alloc]initWithFirstName:@"Erich" andSecondName:@"Gamma"]
//                  ];
