//
//  BookCollection.h
//  VerticlePrototype
//
//  Created by Trevor Bliss on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

@interface BookCollection : NSObject

@property (nonatomic) NSMutableArray *collection;
@property (nonatomic, readonly) NSMutableArray *readBooks;
@property (nonatomic, readonly) NSMutableArray *readingBooks;
@property (nonatomic, readonly) NSMutableArray *lentBooks;
@property (nonatomic, readonly) NSMutableArray *allBooks;

- (id) init;
- (id) initWithBooks:(NSMutableArray*) books;
- (void) refreshArrays;
- (void) deleteBook: (NSNumber*)index;
- (void) editBook: (Book*)newBook: (NSNumber*)index;
- (void) addBook: (Book*)book;
- (BOOL) duplicateName: (NSString*)name;

@end
