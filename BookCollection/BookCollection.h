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
@property (nonatomic, readonly) NSMutableArray *allBooks;

- (id) init;
- (id) initWithBooks:(NSMutableArray*) books;
- (void) refreshArrays;
- (void) deleteBook: (NSNumber*)index;
- (void) changeBookState: (NSNumber*)state: (NSNumber*)index;
- (void) addBook: (Book*)book;

@end
