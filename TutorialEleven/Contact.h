//
//  Contact.h
//  TutorialEleven
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//



@import Foundation;





@interface Contact : NSObject

@property NSString * firstName;
@property NSString * secondName;
@property NSString * firstSymbols;
@property NSString * avatarColor;

- (instancetype)initWithFirstName: (NSString*)name andSecondName: (NSString*)second;

@end
    
    


