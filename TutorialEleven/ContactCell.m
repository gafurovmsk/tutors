//
//  contactCell.m
//  TutorialEleven
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ContactCell.h"
#import "QuartzCore/CALayer.h"
@import Masonry;


@implementation ContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.reuseID = reuseIdentifier;
        
        self.nameLabel = [UILabel new];
        self.secondLabel = [UILabel new];
        self.imageSymbolsLabel = [UILabel new];
        self.avatar = [UIImageView new];
        
        
        [self addSubview: self.nameLabel];
        [self addSubview: self.secondLabel];
        self.avatar.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.avatar];
        [self.avatar  addSubview:self.imageSymbolsLabel];
        
        [self makeConstraints];
        
        
        
    }
       return self;
}

-(void)makeConstraints{
    
    UIView *ourView = self.superview;
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_top);
        make.left.equalTo(self.imageView.mas_left);
        make.width.with.offset(30);
        make.height.with.offset(30);
     //   make.bottom.equalTo(self.imageView.mas_bottom).with.offset(-10);
     //   make.right.equalTo(self.imageView.mas_right).with.offset(-10);
    }];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ourView.mas_top);
        make.left.equalTo(self.avatar.mas_left).with.offset(10);
        make.bottom.equalTo(ourView.mas_bottom).with.offset(-10);
        make.right.equalTo(ourView.mas_right).with.offset(-10);
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ourView.mas_top).with.offset(20);
        make.left.equalTo(self.avatar.mas_left).with.offset(10);
        make.bottom.equalTo(ourView.mas_bottom).with.offset(-10);
        make.right.equalTo(ourView.mas_right).with.offset(-10);
    }];
    
    [self.imageSymbolsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatar.mas_top);
        make.left.equalTo(self.avatar.mas_left).with.offset(10);
        make.bottom.equalTo(self.avatar.mas_bottom).with.offset(-10);
        make.right.equalTo(self.avatar.mas_right).with.offset(-10);
    }];
    

}



- (void)awakeFromNib {
    [super awakeFromNib];
  
    CALayer *cellImageLayer = self.imageView.layer;
    [cellImageLayer setCornerRadius:9];
    [cellImageLayer setMasksToBounds:YES];

   

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
