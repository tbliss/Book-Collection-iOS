//
//  ScannerVC.h
//  BookCollection
//
//  Created by Trevor Bliss on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScannerKit.h"
#import "AddBookVC.h"

@interface ScannerVC : UIViewController <SKScannerViewControllerDelegate>

@property (nonatomic) AddBookVC *addBookVC;

- (void) startScan;

@end
