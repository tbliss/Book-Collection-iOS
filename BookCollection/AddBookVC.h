//
//  AddBookVC.h
//  BookCollection
//
//  Created by Trevor Bliss on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "BookCollection.h"
#include "ScannerKit.h"

@interface AddBookVC : UIViewController <NSXMLParserDelegate, UITextFieldDelegate>

@property (nonatomic) BookCollection *bookCollection;

@property (nonatomic) IBOutlet UITextField *bookTitle;
@property (nonatomic) IBOutlet UITextField *bookAuthor;
@property (nonatomic) IBOutlet UITextField *lentToName;
@property (nonatomic) IBOutlet UISwitch *lentToSwitch;
@property (nonatomic) IBOutlet UISwitch *readSwitch;
@property (nonatomic) IBOutlet UISwitch *readingSwitch;

@property (nonatomic) NSString *switchOn;

@property (nonatomic) NSMutableString *currElementValue;
@property (nonatomic) UITextField *currTextField;

-(IBAction)addBook:(id)sender;

- (void) sendISBN: (NSString*)isbn;

-(IBAction)backgroundTouched:(id)sender;
-(void) setupTextFields;
-(void) cancelAdd;


@end
