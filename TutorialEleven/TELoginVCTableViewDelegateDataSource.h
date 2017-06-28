//
//  TELoginVCTableViewDelegateDataSource.h
//  TutorialEleven
//
//  Created by Nik on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TELoginViewController;
@import UIKit;

@interface TELoginVCTableViewDelegateDataSource : NSObject <UITableViewDelegate,UITableViewDataSource>

-(instancetype)initWithController:(TELoginViewController *)controller;

@end
