//
//  CColorDictionary.m
//  TutorialEleven
//
//  Created by iOS-School-1 on 27.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CColorDictionary.h"
@import UIKit;

@implementation CColorDictionary

+ (UIColor*)generateColorWithString:(NSString *)symbols{
    
    CGFloat alpha = 0.58;
    
    int asciiFirst = [symbols characterAtIndex:0];
    int asciiSecond = [symbols characterAtIndex:1];
    
    switch ((asciiFirst + asciiSecond) % 7) {
        case 0:
            return [[UIColor redColor]colorWithAlphaComponent:alpha];
            break;
            
        case 1:
            return [[UIColor orangeColor]colorWithAlphaComponent:alpha];
            break;
            
        case 2:
            return [[UIColor yellowColor]colorWithAlphaComponent:alpha];
            break;
            
        case 3:
            return [[UIColor greenColor]colorWithAlphaComponent:alpha];
            break;
            
        case 4:
            return [[UIColor blueColor]colorWithAlphaComponent:alpha];
            break;
            
        case 5:
            return [[UIColor cyanColor]colorWithAlphaComponent:alpha];
            break;
        case 6:
            return [[UIColor purpleColor]colorWithAlphaComponent:alpha];
            break;
        default:
            break;
    }
    return nil;
}
@end
