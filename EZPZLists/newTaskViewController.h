//
//  newTaskViewController.h
//  EZPZLists
//
//  Created by krcox1 on 11/2/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "DetailViewController.h"
#import "MasterViewController.h"

@interface newTaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDatePicker;
@property list *parentList;
@end
