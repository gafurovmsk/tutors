//
//  contactCell.m
//  TutorialEleven
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ContactCell.h"
#import "QuartzCore/CALayer.h"
#import "Contact.h"
#import "CColorDictionary.h"
@import Masonry;

@interface ContactCell()

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *secondLabel;
@property (nonatomic, strong)UILabel *imageSymbolsLabel;
@property (nonatomic,strong)UIImageView *avatar;

@end

@implementation ContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [UILabel new];
        _secondLabel = [UILabel new];
        _imageSymbolsLabel = [UILabel new];
        _avatar = [UIImageView new];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      
        [self addSubview: self.nameLabel];
        [self addSubview: self.secondLabel];
        [self addSubview:self.avatar];
        [self.avatar  addSubview:self.imageSymbolsLabel];
        
        [self makeConstraints];
      
    }
       return self;
}

-(void)makeConstraints{
    
    UIView *ourView = self.contentView;
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.width.height.with.offset(42);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
  
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ourView.mas_top);
        make.left.equalTo(self.avatar.mas_right).with.offset(16);
        }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.left.equalTo(self.avatar.mas_right).with.offset(16);
    }];
    
    [self.imageSymbolsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.avatar.mas_centerX);
      make.centerY.equalTo(self.avatar.mas_centerY);
    }];
  
  // and circling avatar
    CALayer *cellImageLayer = self.avatar.layer;
    [cellImageLayer setCornerRadius:21];
    [cellImageLayer setMasksToBounds:YES];
    [cellImageLayer setBorderWidth:1];
}

-(void)addContact: (Contact*) contact{
  
  self.nameLabel.text = contact.firstName;
  self.secondLabel.text = contact.secondName;
  self.imageSymbolsLabel.text = contact.firstSymbols;
  self.avatar.backgroundColor = [CColorDictionary generateColorWithString:contact.firstSymbols];
}
@end
