//
//  ViewController.m
//  TutorialEleven
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ViewController.h"
#import "Contact.h"
#import "QuartzCore/CALayer.h"
#import "ContactCell.h"
#import "CColorDictionary.h"
#import "ApiManager.h"
@import Masonry;

//const NSString *cellId = @"cellId";

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *contactTable;
@property (nonatomic,strong) NSArray<Contact*> *list;
@property (nonatomic,strong) ApiManager *sharedManager;

@end

@implementation ViewController

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
  
    [self.contactTable registerClass: ContactCell.self forCellReuseIdentifier:@"customID"];
    
    self.contactTable.delegate = self;
    self.contactTable.dataSource = self;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    ContactCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"customID"];
  
    customCell.nameLabel.text = self.list[indexPath.row].firstName;
    customCell.avatar.backgroundColor = [CColorDictionary generateColorWithString:self.list[indexPath.row].firstSymbols];  
    customCell.secondLabel.text = self.list[indexPath.row].secondName;
    customCell.imageSymbolsLabel.text = self.list[indexPath.row].firstSymbols;

    return customCell;
}

@end
