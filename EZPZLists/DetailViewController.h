//
//  DetailViewController.h
//  EZPZLists
//
//  Created by krcox1 on 10/27/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "list.h"
#import "Task.h"
#import "newTaskViewController.h"
#import "taskViewController.h"
#import "CompletedViewController.h"

@interface DetailViewController : UITableViewController
- (IBAction)longCompleteGesture:(UILongPressGestureRecognizer *)sender;


@property (strong, nonatomic) list *list;
//@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end

