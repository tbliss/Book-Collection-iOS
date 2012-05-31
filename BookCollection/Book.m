//
//  Book.m
//  VerticlePrototype
//
//  Created by Trevor Bliss on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Book.h"

@implementation Book
@synthesize title = _title;
@synthesize author = _author;
@synthesize read = _read;
@synthesize reading = _reading;
@synthesize lentOut = _lentOut;
@synthesize lentTo = _lentTo;
@synthesize index = _index;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeBool:self.read forKey:@"read"];
    [aCoder encodeBool:self.reading forKey:@"reading"];
    [aCoder encodeBool:self.lentOut forKey:@"lentOut"];
    [aCoder encodeObject:self.lentTo forKey:@"lentTo"];
    [aCoder encodeObject:self.index forKey:@"index"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.author = [aDecoder decodeObjectForKey:@"author"];
    self.read = [aDecoder decodeBoolForKey:@"read"];
    self.reading = [aDecoder decodeBoolForKey:@"reading"];
    self.lentOut = [aDecoder decodeBoolForKey:@"lentOut"];
    self.lentTo = [aDecoder decodeObjectForKey:@"lentTo"];
    self.index = [aDecoder decodeObjectForKey:@"index"];
    return self;
}

@end
