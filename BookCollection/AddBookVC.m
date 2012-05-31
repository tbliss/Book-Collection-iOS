//
//  AddBookVC.m
//  BookCollection
//
//  Created by Trevor Bliss on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddBookVC.h"
#import "Book.h"
#import "ScannerVC.h"

@implementation AddBookVC
@synthesize bookCollection = _bookCollection;
@synthesize bookTitle = _bookTitle;
@synthesize bookAuthor = _bookAuthor;
@synthesize lentToName = _lentToName;
@synthesize lentToSwitch = _lentToSwitch;
@synthesize readSwitch = _readSwitch;
@synthesize readingSwitch = _readingSwitch;

@synthesize switchOn = _switchOn;

@synthesize currElementValue = _currElementValue;
@synthesize currTextField = _currTextField;

-(void) setupTextFields
{
    self.bookTitle.delegate = self;
    self.bookAuthor.delegate = self;
    self.lentToName.delegate = self;
    
    self.bookTitle.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.bookTitle.returnKeyType = UIReturnKeyNext;
    
    self.bookAuthor.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.bookAuthor.returnKeyType = UIReturnKeyNext;
    
    self.lentToName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.lentToName.returnKeyType = UIReturnKeyDone;
}

-(void) cancelAdd
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) viewDidLoad
{   
    [self setupTextFields];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" 
                                     style:UIBarButtonSystemItemCancel 
                                    target:self 
                                    action:@selector(cancelAdd)];
    self.navigationItem.leftBarButtonItem = backButton;
        
    if ([self.switchOn isEqualToString:@"read"]) {
        self.readSwitch.on = YES;
    } else if ([self.switchOn isEqualToString:@"reading"]) {
        self.readingSwitch.on = YES;
    } else if ([self.switchOn isEqualToString:@"lentOut"]) {
        self.lentToSwitch.on = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)addBook:(id)sender
{
    NSString *rawString = [self.bookTitle text];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    
    if ([trimmed  length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Enter Title" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    } 
    
    if ([self.bookCollection duplicateName:trimmed]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Duplicate Name" message:@"Please edit/delete duplicate entry before adding" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    Book *book = [[Book alloc] init];
    book.title = self.bookTitle.text;
    book.author = self.bookAuthor.text;
    book.lentOut = self.lentToSwitch.on;
    book.lentTo = self.lentToName.text;
    book.read = self.readSwitch.on;
    book.reading = self.readingSwitch.on;

    [self.bookCollection addBook:book];    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) sendISBN: (NSString*)isbn
{
    NSLog(@"sendISBN");
    NSString *baseUrl = @"http://www.isbndb.com/api/books.xml?access_key=98QZ8588&index1=isbn&value1=";
    NSString *fullUrl = [baseUrl stringByAppendingString:isbn];    
    NSURL *url = [NSURL URLWithString:fullUrl];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser parse];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([@"ScannerSegue" isEqualToString:segue.identifier]) {
        ScannerVC *scannerVC = (ScannerVC*)segue.destinationViewController;
        scannerVC.addBookVC = self;
    }
}


#pragma mark NSXMLParserDelegate Methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"elementname: %@", elementName);
    self.currElementValue = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    int stringLen = [string length];
    
    if(!self.currElementValue && stringLen > 1)
        self.currElementValue = [NSMutableString stringWithString:string];
    else
        [self.currElementValue appendString:string];
    
    //NSLog(@"Processing Value: %@", self.currElementValue);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"end elementName: %@", elementName);
    
    if ([elementName isEqualToString:@"Title"]) {
        self.bookTitle.text = self.currElementValue;
    } else if ([elementName isEqualToString:@"AuthorsText"]) {
        self.bookAuthor.text = self.currElementValue;
    }
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
    if (self.bookTitle == textField) {
        [self.bookAuthor becomeFirstResponder];
    } else if (self.bookAuthor == textField) {
        [self.lentToName becomeFirstResponder];
    } else if (self.lentToName == textField) {
        [textField resignFirstResponder];
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
