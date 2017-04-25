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
@import Masonry;

//const NSString *cellId = @"cellId";

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *contactTable;
@property (nonatomic,strong) NSArray<Contact *>* list;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIEdgeInsets edgesInsets =  UIEdgeInsetsMake(0, 8, 8, 8);
    
    self.contactTable = [UITableView new];
    [self.view addSubview:self.contactTable];
    
    [self.contactTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(edgesInsets);
    }];
    
    
    self.list = @[
                  [[Contact alloc]initWithFirstName:@"Alan" andSecondName:@"Kay"],
                  [[Contact alloc]initWithFirstName:@"Bjarne " andSecondName:@"Stroustrup"],
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
    
  // UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
  
    ContactCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"customID"];
    
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.list[indexPath.row].firstName];
//    [cell.imageView setTintColor:[UIColor blueColor]];
//    cell.imageView.backgroundColor = [UIColor yellowColor];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.list[indexPath.row].secondName];
    
    customCell.nameLabel.text = [NSString stringWithFormat:@"%@",self.list[indexPath.row].firstName];
    [customCell.imageView setTintColor:[UIColor blueColor]];
    customCell.imageView.backgroundColor = [UIColor yellowColor];
    customCell.secondLabel.text = [NSString stringWithFormat:@"%@",self.list[indexPath.row].secondName];

    
    
    
    
//    CALayer *cellImageLayer = cell.imageView.layer;
//    [cellImageLayer setCornerRadius:9];
//    [cellImageLayer setMasksToBounds:YES];
    
    
    return customCell;
}


-(UIColor*)colorGenerator: (NSString*) name{
    
    
    
    return [UIColor yellowColor];
}



@end
