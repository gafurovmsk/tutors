//
//  contactCell.h
//  TutorialEleven
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;

@interface ContactCell : UITableViewCell

@property (nonatomic, strong)UILabel *firstNameLabel;
@property (nonatomic, strong)UILabel *secondNameLabel;
@property (nonatomic, strong)UILabel *imageSymbolsLabel;
@property (nonatomic,strong)UIImageView *contactImage;

+(CGFloat)heightForCell;

@end
