//
//  BookViewController.h
//  VerticlePrototype
//
//  Created by Trevor Bliss on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookCollection.h"

@interface BookViewController : UIViewController

@property (nonatomic) IBOutlet UISegmentedControl *bookState;
@property (nonatomic) IBOutlet UILabel *bookTitle;
@property (nonatomic) IBOutlet UILabel *bookAuthor;

@property (nonatomic) BookCollection *collection;
@property (nonatomic) NSString *myTitle;
@property (nonatomic) NSString *myAuthor;
@property (nonatomic) NSString *myState;
@property (nonatomic) NSNumber *index;

- (void) bookStateChanged;
- (void) deleteBook;

@end
