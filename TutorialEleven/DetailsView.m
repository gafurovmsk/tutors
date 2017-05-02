//
//  DetailsView.m
//  TutorialEleven
//
//  Created by Nik on 01.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "DetailsView.h"
#import "CColorDictionary.h"
@import Masonry;

@interface DetailsView()

@property (nonatomic,strong) UIView *setView;
@property (nonatomic,strong) UILabel *firstName;
@property (nonatomic,strong) UILabel *secondName;
@property (nonatomic,strong) UILabel *firstSymbols;

@end

@implementation DetailsView

-(instancetype)init{
  
  self = [super init];
  if (!self) return nil;

  self.backgroundColor = [UIColor darkGrayColor];
  
  _firstName = [UILabel new];
  _firstName.text = @"Testname";
  [self addSubview:_firstName];

  _secondName = [UILabel new];
  _secondName.text = @"Secondtest";
  [self addSubview:_secondName];
  
  _setView = [UIView new];
  _setView.backgroundColor = [UIColor magentaColor];
  [self addSubview:_setView];
  
  _firstSymbols = [UILabel new];
  _firstSymbols.text = @"TS";
  [self.setView addSubview:_firstSymbols];
  
  [self makeConstraints];
  return self;
}

-(void)makeConstraints {
  
  [_setView mas_makeConstraints:^(MASConstraintMaker *make) {
    // почему сколько бы не настроить top ofset все равно он закреплен к топу?
    //make.top.equalTo(self.mas_top).with.offset(8);
    make.left.equalTo(self.mas_left).with.offset(8);
    make.right.equalTo(self.mas_right).with.offset(-8);
    make.height.equalTo(@200);
  }];
  
  [_firstSymbols mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.setView.mas_centerX);
    make.centerY.equalTo(self.setView.mas_centerY);
  }];
  
  [_firstName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.mas_left).with.offset(8);
    make.top.equalTo(self.setView.mas_bottom).with.offset(8);
  }];
  
  [_secondName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.firstName.mas_right).with.offset(8);
    make.top.equalTo(self.setView.mas_bottom).with.offset(8);
  }];
}

-(void)addThisContact:(Contact *)contact{
  
  self.firstName.text = contact.firstName;
  self.secondName.text = contact.secondName;
  self.firstSymbols.text = contact.firstSymbols;
  self.setView.backgroundColor = [CColorDictionary generateColorWithString:contact.firstSymbols];
}

@end
