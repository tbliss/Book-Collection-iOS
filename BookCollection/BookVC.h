//
//  BookViewController.h
//  VerticlePrototype
//
//  Created by Trevor Bliss on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookCollection.h"
#import "Book.h"

@interface BookVC: UIViewController <UITextFieldDelegate>

@property (nonatomic) IBOutlet UILabel *bookTitle;
@property (nonatomic) IBOutlet UILabel *bookAuthor;
@property (nonatomic) IBOutlet UITextField *lentOutName;
@property (nonatomic) IBOutlet UISwitch *lentOutSwitch;
@property (nonatomic) IBOutlet UISwitch *read;
@property (nonatomic) IBOutlet UISwitch *reading;

@property (nonatomic) BookCollection *collection;
@property (nonatomic) Book *book;
@property (nonatomic) Book *editedBook;

@property (nonatomic) UITextField *currTextField;

- (IBAction)bookEdited:(id)sender;
- (void) deleteBook;
- (void) updateNewBook;

@end
