//
//  BookViewController.m
//  VerticlePrototype
//
//  Created by Trevor Bliss on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BookViewController.h"

@interface BookViewController ()

@end

@implementation BookViewController
@synthesize bookState = _bookState;
@synthesize bookTitle = _bookTitle;
@synthesize bookAuthor = _bookAuthor;
@synthesize collection = _collection;
@synthesize myTitle = _myTitle;
@synthesize myAuthor = _myAuthor;
@synthesize myState = _myState;
@synthesize index = _index;

- (void) bookStateChanged
{
    if (self.bookState.selectedSegmentIndex == 0) {
        [self.collection changeBookState:[NSNumber numberWithInt:0] :self.index];
    } 
    else if (self.bookState.selectedSegmentIndex == 1) {
        [self.collection changeBookState:[NSNumber numberWithInt:1] :self.index];
    } 
    else if (self.bookState.selectedSegmentIndex == 2) {
        [self.collection changeBookState:[NSNumber numberWithInt:2] :self.index];
    }
}

- (void) deleteBook
{
    [self.collection deleteBook:self.index];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bookTitle.text = self.myTitle;
    self.bookAuthor.text = self.myAuthor;
    
    if ([self.myState isEqualToString:@"read"]) {
        self.bookState.selectedSegmentIndex = 0;
    } else if ([self.myState isEqualToString:@"reading"]) {
        self.bookState.selectedSegmentIndex = 1;
    } else if ([self.myState isEqualToString:@"wishlist"]) {
        self.bookState.selectedSegmentIndex = 2;
    }
    
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] 
                                       initWithTitle:@"Delete" 
                                       style:UIBarButtonItemStylePlain
                                       target:self 
                                       action:@selector(deleteBook)];
    self.navigationItem.rightBarButtonItem = deleteButton;
    
	[self.bookState addTarget:self 
                       action:@selector(bookStateChanged) 
             forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidUnload
{
    //NSLog(@"BookViewController viewDidUnload");
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
