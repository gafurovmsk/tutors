//
//  DetailsView.m
//  TutorialEleven
//
//  Created by Nik on 01.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "DetailsView.h"
#import "CColorDictionary.h"
#import "QuartzCore/CALayer.h"
@import Masonry;

CGFloat const imageHeight = 180;

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

  self.backgroundColor = [UIColor lightGrayColor];
  
  _firstName = [UILabel new];
  _firstName.text = @"Testname";
  [self addSubview:_firstName];

  _secondName = [UILabel new];
  _secondName.text = @"Secondtest";
  [self addSubview:_secondName];
  
  _setView = [UIView new];
  _setView.backgroundColor = [UIColor magentaColor];
  [_setView.layer setMasksToBounds:YES];
  [_setView.layer setCornerRadius:imageHeight/2];
  [_setView.layer setBorderWidth:1];
  [_setView setContentMode:UIViewContentModeScaleAspectFit];
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
    make.top.equalTo(self.mas_top).with.offset(66);
    make.centerX.equalTo(self.mas_centerX);
    make.height.width.equalTo(@(imageHeight));
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
    make.left.equalTo(self.mas_left).with.offset(8);
    make.top.equalTo(self.firstName.mas_bottom).with.offset(8);
  }];
}

-(void)addContactWithName:(NSString *)firstName andSecond:(NSString *)secondName andImage:(NSData *)imageData{
  NSString *name = [@"Имя: " stringByAppendingString: firstName];
  NSString *sName = [@"Фамилия: " stringByAppendingString:secondName];
  //[NSString stringWithFormat:@"%@%@", sample1,sample2];
  
  self.firstName.text = name;
  self.secondName.text = sName;
  if (!imageData){
  self.setView.backgroundColor = [CColorDictionary generateColorWithString:firstName];
  } else {
    [self.setView addSubview:[[UIImageView alloc]initWithImage:[UIImage imageWithData:imageData]]];
  }
}

@end
