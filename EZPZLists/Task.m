//
//  Task.m
//  EZPZLists
//
//  Created by krcox1 on 11/2/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import "Task.h"

@implementation Task

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self=[super init]))
    {
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.detail=[aDecoder decodeObjectForKey:@"detail"];
        self.due=[aDecoder decodeObjectForKey:@"due"];
        self.recurAfter=[aDecoder decodeIntegerForKey:@"recurAfter"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.detail forKey:@"detail"];
    [aCoder encodeObject:self.due forKey:@"due"];
    [aCoder encodeInteger:self.recurAfter forKey:@"recurAfter"];
}



@end
