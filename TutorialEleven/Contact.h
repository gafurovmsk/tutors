//
//  Contact.h
//  TutorialEleven
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//



@import Foundation;

@interface Contact : NSObject

@property (copy,nonatomic) NSString *firstName;
@property (copy,nonatomic) NSString *secondName;
@property (copy,nonatomic) NSString *imageSymbols;
@property (strong,nonatomic) NSData *contactImageData;

- (instancetype)initWithFirstName:(NSString *)name andSecondName:(NSString *)second;
- (instancetype)initWithImage:(NSData *)image andFirst:(NSString *)name andLastName:(NSString *)last;

@end
    
    


