//
//  AppDelegate.h
//  BookCollection
//
//  Created by Trevor Bliss on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookCollection.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BookCollection *bookCollection;

- (void)saveState;
- (void)populateExData;

@end
