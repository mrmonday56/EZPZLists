//
//  newListViewController.h
//  EZPZLists
//
//  Created by krcox1 on 11/2/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MasterViewController;
#import "list.h"

@interface newListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property MasterViewController *parent;
@end
