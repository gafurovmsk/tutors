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

@import Masonry;

CGFloat const cellHeight = 50;

@interface ContactCell()

@end

@implementation ContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _firstNameLabel = [UILabel new];
        _secondNameLabel = [UILabel new];
        _imageSymbolsLabel = [UILabel new];
        _contactImage = [UIImageView new];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      
        CALayer *cellImageLayer = _contactImage.layer;
        [cellImageLayer setCornerRadius:(cellHeight-8)/2];
        [cellImageLayer setMasksToBounds:YES];
        [cellImageLayer setBorderWidth:1];
        [_contactImage setContentMode:UIViewContentModeScaleAspectFit];
      
        [self addSubview: self.firstNameLabel];
        [self addSubview: self.secondNameLabel];
        [self addSubview:self.contactImage];
        [self.contactImage  addSubview:self.imageSymbolsLabel];
        
        [self makeConstraints];
      
    }
       return self;
}

-(void)makeConstraints{
    
    UIView *ourView = self.contentView;
    
    [self.contactImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(4);
        make.left.equalTo(self.contentView.mas_left).with.offset(4);
        make.height.width.equalTo(@(cellHeight-8));
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(4);
    }];
  
    [self.firstNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ourView.mas_top);
        make.left.equalTo(self.contactImage.mas_right).with.offset(16);
        }];
    
    [self.secondNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstNameLabel.mas_bottom);
        make.left.equalTo(self.contactImage.mas_right).with.offset(16);
    }];
    
    [self.imageSymbolsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.contactImage.mas_centerX);
      make.centerY.equalTo(self.contactImage.mas_centerY);
    }];
  
  // and circling avatar
    }

+(CGFloat)heightForCell {
  return cellHeight;
}

@end
