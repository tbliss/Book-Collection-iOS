//
//  AllVC.m
//  BookCollection
//
//  Created by Trevor Bliss on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AllVC.h"
#import "BookVC.h"
#import "AddBookVC.h"

@interface AllVC ()

@end

@implementation AllVC
@synthesize bookCount = _bookCount;
@synthesize bookCollection = _bookCollection;   
@synthesize books = _books;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setColl: (BookCollection *)coll
{
    [self view];
    self->_bookCollection = coll;
    [self refreshTable];
}

- (void) refreshTable
{
    //[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:YES];
    self.books = [NSMutableArray arrayWithCapacity:0];
    self.bookCount = 0;
    [self.tableView reloadData];
    
    self.books = self.bookCollection.allBooks;
    self.bookCount = self.books.count;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.bookCollection)
        return;
    
    [self refreshTable];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.bookCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AllBook";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (indexPath.section == 0) {
        for (int i = 0; i < self.bookCount; i++) {
            if (indexPath.row == i) {
                Book *currBook = [self.books objectAtIndex:i];
                cell.textLabel.text = currBook.title;
                cell.tag = i;
            }
        }
    }
    
    // Let user know another view if pressed
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([@"AllBookView" isEqualToString:segue.identifier]) {
        BookVC *bookView = (BookVC*)segue.destinationViewController;
        
        UITableViewCell *tableCell = sender;
        Book *book = [self.books objectAtIndex:tableCell.tag];
        bookView.book = book;
        bookView.collection = self.bookCollection;
    }  else if ([@"AddBook4" isEqualToString:segue.identifier]) {
        AddBookVC *addBook = (AddBookVC*)segue.destinationViewController;
        addBook.bookCollection = self.bookCollection;
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableCell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"AllBookView" sender:tableCell];
}

@end
