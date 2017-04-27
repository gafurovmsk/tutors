//
//  Contact.m
//  TutorialEleven
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"



@interface Contact()
//@property NSString * firstName;
//@property NSString * secondName;
//@property NSString * firstSymbols;

@end



@implementation Contact : NSObject 


- (instancetype)initWithFirstName: (NSString*)name andSecondName: (NSString*)second {
    self = [super init];
    if (self) {
        _firstName = name;
        _secondName = second;
        _firstSymbols = [NSString stringWithFormat:@"%@%@",[name substringToIndex:1],[second substringToIndex:1]];
        
        
    }
    return self;
}

-(NSString *)generateColor{
  
    
    
    
  return @"dd";
}


@end
