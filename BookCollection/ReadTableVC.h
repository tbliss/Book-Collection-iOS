//
//  ReadTableVC.h
//  BookCollection
//
//  Created by Trevor Bliss on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookCollection.h"

@interface ReadTableVC : UITableViewController <UIActionSheetDelegate>

@property (nonatomic) int bookCount;
@property (nonatomic) BookCollection *bookCollection;
@property (nonatomic) NSMutableArray *books;

- (void) setColl: (BookCollection *)coll;
- (void) refreshTable;

- (void)showActionSheet;

@end
