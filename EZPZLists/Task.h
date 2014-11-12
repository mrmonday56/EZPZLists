//
//  Task.h
//  EZPZLists
//
//  Created by krcox1 on 11/2/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject
@property NSString *name;
@property NSString *detail;
@property NSDate *due;
@property NSInteger recurAfter;

@end
