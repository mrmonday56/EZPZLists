//
//  MasterViewController.h
//  EZPZLists
//
//  Created by krcox1 on 10/27/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "newListViewController.h"
#import "list.h"

@interface MasterViewController : UITableViewController

-(void)addList:(list*) newList;
-(void)saveLists;
@end

