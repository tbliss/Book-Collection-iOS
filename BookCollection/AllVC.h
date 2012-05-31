//
//  AllVC.h
//  BookCollection
//
//  Created by Trevor Bliss on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookCollection.h"

@interface AllVC : UITableViewController

@property (nonatomic) int bookCount;
@property (nonatomic) BookCollection *bookCollection;
@property (nonatomic) NSMutableArray *books;

- (void) setColl: (BookCollection *)coll;
- (void) refreshTable;

@end
