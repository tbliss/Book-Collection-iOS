//
//  BookTabVC.m
//  VerticlePrototype
//
//  Created by Trevor Bliss on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BookTabVC.h"
#import "ReadTableVC.h"
#import "ReadingTableVC.h"
#import "LentOutTableVC.h"
#import "AllVC.h"

@interface BookTabVC ()

@end

@implementation BookTabVC
@synthesize bookCollection = _bookCollection;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ReadTableVC *readVC = (ReadTableVC*)[[self.viewControllers objectAtIndex:0] topViewController];
    ReadingTableVC *readingVC = (ReadingTableVC*)[[self.viewControllers objectAtIndex:1] topViewController];
    LentOutTableVC *lentOutVC = (LentOutTableVC*)[[self.viewControllers objectAtIndex:2] topViewController];
    AllVC *allVC = (AllVC*)[[self.viewControllers objectAtIndex:3] topViewController];
    
    [readVC setColl:self.bookCollection];
    [readingVC setColl:self.bookCollection];
    [lentOutVC setColl:self.bookCollection];
    [allVC setColl:self.bookCollection];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
