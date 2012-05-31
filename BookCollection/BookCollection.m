//
//  BookCollection.m
//  VerticlePrototype
//
//  Created by Trevor Bliss on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BookCollection.h"

@interface BookCollection ()
@property (nonatomic) NSMutableArray *allBooks;
@end

@implementation BookCollection
@synthesize collection = _collection;
@synthesize allBooks = _allBooks;

- (id) init
{
    return [self initWithBooks:[NSMutableArray array]];
}

- (id) initWithBooks: (NSMutableArray*)books
{
    self.collection = books;
    self.allBooks = [NSMutableArray arrayWithCapacity:books.count];
    [self refreshArrays];
    return self;
}

- (void) refreshArrays
{
    NSMutableArray *tempBooks = [NSMutableArray arrayWithCapacity:self.collection.count];
    for (int i = 0; i < self.collection.count; i++) {
        NSMutableDictionary *dict = [self.collection objectAtIndex:i];
        [dict setObject:[NSNumber numberWithInt:i] forKey:@"index"];
        [tempBooks addObject:[self.collection objectAtIndex:i]];
        //[self.allBooks addObject:[self.collection objectAtIndex:i]];
    }
    self.allBooks = tempBooks;
}

- (void) deleteBook: (NSNumber*)index
{
    //NSLog(@"deleting book: %d", [index intValue]);
    [self.collection removeObjectAtIndex:[index intValue]];
    [self refreshArrays];
}

- (void) changeBookState: (NSNumber*)state: (NSNumber*)index
{
    NSMutableDictionary *dict = [self.collection objectAtIndex:[index intValue]];
    if ([state intValue] == 0) {
        [dict setObject:@"read" forKey:@"state"];
    } else if ([state intValue] == 1) {
        [dict setObject:@"reading" forKey:@"state"];
    } else if ([state intValue] == 1) {
        [dict setObject:@"wishlist" forKey:@"state"];
    }
    [self refreshArrays];
}

- (void) addBook: (Book*)book
{
    NSMutableDictionary *book1 = [NSMutableDictionary dictionaryWithCapacity:2];
    
    NSString *title = book.title;
    NSString *author = @"J. D. Salinger";
    NSString *state = @"read";
    [book1 setObject:title forKey:@"title"];
    [book1 setObject:author forKey:@"author"];
    [book1 setObject:state forKey:@"state"];
    //[bookArray addObject:book1];
    
    [self.collection addObject:book1];
    
    [self refreshArrays];
}

@end
