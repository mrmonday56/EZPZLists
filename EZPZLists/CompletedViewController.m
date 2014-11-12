//
//  CompletedViewController.m
//  EZPZLists
//
//  Created by krcox1 on 11/3/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//  THIS CLASS NO LONGER IN ACTIVE USE

#import "CompletedViewController.h"

@interface CompletedViewController ()
- (IBAction)uncompleteButton:(UIButton *)sender;
@property BOOL showCompleted;
@end

@implementation CompletedViewController

-(void)viewWillAppear:(BOOL)animated{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"due"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    self.list.completedTasks = [NSMutableArray arrayWithArray:[self.list.tasks sortedArrayUsingDescriptors:sortDescriptors]];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showCompleted=true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.completedTasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Task *task = self.list.completedTasks[indexPath.row];
    cell.textLabel.text = task.name;
    cell.detailTextLabel.text=@"completed";
        
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Task *newTask=[self.list.completedTasks objectAtIndex:indexPath.row];
        [self.list.tasks addObject:newTask];
        [self.list.completedTasks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.navigationController.viewControllers[0] saveLists];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
}

- (IBAction)uncompleteButton:(UIButton *)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    Task *newTask=[self.list.completedTasks objectAtIndex:indexPath.row];
    [self.list.tasks addObject:newTask];
    [self.list.completedTasks removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.navigationController.viewControllers[0] saveLists];
}

@end
