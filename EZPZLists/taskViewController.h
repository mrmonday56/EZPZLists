//
//  taskViewController.h
//  EZPZLists
//
//  Created by krcox1 on 11/3/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "MasterViewController.h"

@interface taskViewController : UIViewController
@property Task *task;
@property (weak, nonatomic) IBOutlet UIDatePicker *duePicker;

@end
