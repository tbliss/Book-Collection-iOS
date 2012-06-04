//
//  BookCollection.m
//  VerticlePrototype
//
//  Created by Trevor Bliss on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BookCollection.h"
#import "Book.h"

@interface BookCollection ()
@property (nonatomic) NSMutableArray *readBooks;
@property (nonatomic) NSMutableArray *readingBooks;
@property (nonatomic) NSMutableArray *lentBooks;
@property (nonatomic) NSMutableArray *allBooks;
@end

@implementation BookCollection
@synthesize collection = _collection;
@synthesize readBooks = _readBooks;
@synthesize readingBooks = _readingBooks;
@synthesize lentBooks = _lentBooks;
@synthesize allBooks = _allBooks;


- (id) init
{
    return [self initWithBooks:[NSMutableArray array]];
}

- (id) initWithBooks: (NSMutableArray*)books
{
    self.collection = books;
    self.readBooks = [NSMutableArray arrayWithCapacity:books.count];
    self.readingBooks = [NSMutableArray arrayWithCapacity:books.count];
    self.lentBooks = [NSMutableArray arrayWithCapacity:books.count];
    self.allBooks = [NSMutableArray arrayWithCapacity:books.count];
    
    [self refreshArrays];
    return self;
}

- (void) refreshArrays
{
    [self.readBooks removeAllObjects];
    [self.readingBooks removeAllObjects];
    [self.lentBooks removeAllObjects];
    [self.allBooks removeAllObjects];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"title" 
                                                               ascending:YES
                                    selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObject:descriptor];
    NSArray *sorted = [self.collection sortedArrayUsingDescriptors:sortDescriptors];
    //self.collection = (NSMutableArray*)sorted;
    self.collection = [NSMutableArray arrayWithArray:sorted];
    
    for (int i=0; i<self.collection.count; i++) {
        Book *currBook = [self.collection objectAtIndex:i];
        currBook.index = [NSNumber numberWithInt:i];
        
        if (currBook.read)
            [self.readBooks addObject:currBook];
        if (currBook.reading)
            [self.readingBooks addObject:currBook];
        if (currBook.lentOut)
            [self.lentBooks addObject:currBook];
        
        [self.allBooks addObject:currBook];
    }
}

- (void) deleteBook: (NSNumber*)index
{
    [self.collection removeObjectAtIndex:[index intValue]];
    [self refreshArrays];
}

- (void) editBook: (Book*)newBook: (NSNumber*)index
{
    [self.collection replaceObjectAtIndex:[index intValue] withObject:newBook];
    [self refreshArrays];
}

- (void) addBook: (Book*)book
{
    [self.collection addObject:book];
    [self refreshArrays];
}

- (BOOL) duplicateName: (NSString*)name
{
    for (int i=0; i<self.collection.count; i++) {
        Book *currBook = [self.collection objectAtIndex:i];
        
        if ([currBook.title isEqualToString:name])
            return YES;
    }

    return NO;
}

@end
