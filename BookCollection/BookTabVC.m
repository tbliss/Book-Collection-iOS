//
//  BookTabVC.m
//  VerticlePrototype
//
//  Created by Trevor Bliss on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BookTabVC.h"
#import "BookTableVC.h"

@interface BookTabVC ()

@end

@implementation BookTabVC
@synthesize bookCollection = _bookCollection;

- (void)viewDidLoad
{
    [super viewDidLoad];
    BookTableVC *tableVC = (BookTableVC*)[[self.viewControllers objectAtIndex:2] topViewController];
    [tableVC setColl:self.bookCollection];
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
