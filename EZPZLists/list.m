//
//  list.m
//  EZPZLists
//
//  Created by krcox1 on 11/2/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import "list.h"

@implementation list

-(void)addTask:(Task*)newTask{
    [self.tasks addObject:newTask];
}

-(id)init{
    self=[super init];
    self.tasks=[[NSMutableArray alloc] init];
    self.completedTasks=[[NSMutableArray alloc] init];
    self.name=[[NSString alloc] init];
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self=[super init]))
    {
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.tasks=[aDecoder decodeObjectForKey:@"tasks"];
        self.completedTasks=[aDecoder decodeObjectForKey:@"completedTasks"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.tasks forKey:@"tasks"];
    [aCoder encodeObject:self.completedTasks forKey:@"completedTasks"];
}

@end
