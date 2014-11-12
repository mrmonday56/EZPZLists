//
//  list.h
//  EZPZLists
//
//  Created by krcox1 on 11/2/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface list : NSObject <NSCoding>
@property NSMutableArray *tasks;
@property NSMutableArray *completedTasks;
@property NSString *name;

-(void)addTask:(Task*)newTask;
@end
