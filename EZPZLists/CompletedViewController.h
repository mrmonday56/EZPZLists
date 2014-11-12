//
//  CompletedViewController.h
//  EZPZLists
//
//  Created by krcox1 on 11/3/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "list.h"
#import "Task.h"
#import "newTaskViewController.h"
#import "taskViewController.h"

@interface CompletedViewController : UITableViewController
@property (strong, nonatomic) list *list;
@end
