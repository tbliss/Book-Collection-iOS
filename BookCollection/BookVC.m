//
//  BookViewController.m
//  VerticlePrototype
//
//  Created by Trevor Bliss on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BookVC.h"

@interface BookVC ()

@end

@implementation BookVC
@synthesize bookTitle = _bookTitle;
@synthesize bookAuthor = _bookAuthor;
@synthesize lentOutName = _lentOutName;
@synthesize lentOutSwitch = _lentOutSwitch;
@synthesize read = _read;
@synthesize reading = _reading;

@synthesize collection = _collection;
@synthesize book = _book;
@synthesize editedBook = _editedBook;

@synthesize currTextField = _currTextField;

- (IBAction)bookEdited:(id)sender
{
    [self updateNewBook];
}

- (void) updateNewBook
{
    Book *book = [[Book alloc] init];
    book.title = self.bookTitle.text;
    book.author = self.bookAuthor.text;
    book.lentOut = self.lentOutSwitch.on;
    book.read = self.read.on;
    book.reading = self.reading.on;
    book.lentTo = self.lentOutName.text;
    book.index = self.book.index;
    
    [self.collection editBook:book :book.index];
}

- (void) deleteBook
{
    [self.collection deleteBook:self.book.index];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    //NSLog(@"BookVC, viewDidLoad: %@", self.book.title);
    [super viewDidLoad];
    
    self.bookTitle.text = self.book.title;
    self.bookTitle.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:22];
    //self.bookTitle.numberOfLines = 1;
    //self.bookTitle.minimumFontSize = 24;
    //self.bookTitle.adjustsFontSizeToFitWidth = YES;
    self.bookAuthor.text = self.book.author;
    self.bookAuthor.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    self.lentOutSwitch.on = self.book.lentOut;
    self.read.on = self.book.read;
    self.reading.on = self.book.reading;
    if (self.lentOutSwitch.on) {
        self.lentOutName.text = self.book.lentTo;
    }
    self.lentOutName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.lentOutName.returnKeyType = UIReturnKeyDone;
    
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] 
                                       initWithTitle:@"Delete" 
                                       style:UIBarButtonItemStylePlain
                                       target:self 
                                       action:@selector(deleteBook)];
    self.navigationItem.rightBarButtonItem = deleteButton;
    
    self.lentOutName.delegate = self;
}

- (void)viewDidUnload
{
    //NSLog(@"BookVC, viewDidUnload: %@", self.book.title);
    [super viewDidUnload];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //NSLog(@"BookVC, viewWillDisappear: %@", self.book.title);
    [super viewWillDisappear:animated];
    [self.navigationController popViewControllerAnimated:YES];
    
    // Update book
    if (self.lentOutSwitch.on && ![self.lentOutName.text isEqualToString:self.book.lentTo]) {
        [self updateNewBook];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


# pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.currTextField == textField) {
        self.currTextField = nil;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.lentOutName == textField) {
        [self.lentOutName resignFirstResponder];
    }
    return YES;
}

-(IBAction)backgroundTouched:(id)sender
{
    if (self.currTextField) {
        [self.currTextField resignFirstResponder];
    }
}


@end
