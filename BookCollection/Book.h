//
//  Book.h
//  VerticlePrototype
//
//  Created by Trevor Bliss on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject <NSCoding>

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *author;
@property (nonatomic) BOOL read;
@property (nonatomic) BOOL reading;
@property (nonatomic) BOOL lentOut;
@property (nonatomic) NSString *lentTo;
@property (nonatomic) NSNumber *index;

@end
