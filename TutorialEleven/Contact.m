//
//  Contact.m
//  TutorialEleven
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@implementation Contact: NSObject

- (instancetype)initWithFirstName: (NSString *)name andSecondName: (NSString *)second{
    self = [super init];
    if (self) {
        _firstName = name;
        _secondName = second;
        _imageSymbols = [NSString stringWithFormat:@"%@%@",
                         [name substringToIndex:1],
                         [second substringToIndex:1]
                         ];
    }
    return self;
}

- (instancetype)initWithImage:(NSData *)image andFirst:(NSString *)name andLastName:(NSString *)last{
  
  self = [self initWithFirstName:name andSecondName:last];
  
  if(self){
    _contactImageData = image;
  }
  return self;
}

@end
