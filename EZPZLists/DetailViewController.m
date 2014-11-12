//
//  DetailViewController.m
//  EZPZLists
//
//  Created by krcox1 on 10/27/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property NSArray *sortedArray;
@property bool showCompleted;

- (IBAction)completeButton:(UIButton *)sender;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

/*- (void)setList:(list*)newList {
    if (_list != newList) {
        _list = newList;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.list) {
        //self.detailDescriptionLabel.text = [self.list description];
    }
}*/

-(void)viewWillAppear:(BOOL)animated{
    [self resortCells];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self configureView];
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.showCompleted=true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.showCompleted)
        return 2;
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!self.showCompleted || section==1)
        return self.list.tasks.count;
    else
        return self.list.completedTasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(!self.showCompleted || indexPath.section==1){
        Task *task = self.list.tasks[indexPath.row];
        cell.textLabel.text = task.name;
    
        double secondsRemaining=[task.due timeIntervalSinceNow];
        double daysRemaining=ceil(secondsRemaining/60/60/24);
        NSString *timeRemaining;
        if(daysRemaining<-1)
            timeRemaining=[NSString stringWithFormat:@"Overdue by %.0f days", fabs(daysRemaining)];
        else if(daysRemaining==0)
            timeRemaining=@"Today";
        else if(daysRemaining==-1)
            timeRemaining=@"Yesterday";
        else if(daysRemaining==1)
            timeRemaining=@"Tomorrow";
        else
            timeRemaining=[NSString stringWithFormat:@"Due in %.0f days",daysRemaining];
    
        cell.detailTextLabel.text=timeRemaining;
        
        return cell;
    }
    else{
        Task *task = self.list.completedTasks[indexPath.row];
        cell.textLabel.text = task.name;
        cell.detailTextLabel.text=@"completed";
        
        return cell;
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Task *newTask=[self.list.tasks objectAtIndex:indexPath.row];
        [self.list.completedTasks addObject:newTask];
        [self.list.tasks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.navigationController.viewControllers[0] saveLists];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"newTask"]) {
        newTaskViewController *nextView=segue.destinationViewController;
        nextView.parentList=self.list;
    }
    if ([[segue identifier] isEqualToString:@"showTask"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Task *task = self.list.tasks[indexPath.row];
        taskViewController *nextView=[segue destinationViewController];
        nextView.task=task;
    }
    if ([[segue identifier] isEqualToString:@"showCompleted"]) {
        CompletedViewController *nextView=segue.destinationViewController;
        nextView.list=self.list;
    }
}

- (IBAction)completeButton:(UIButton *)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    if(indexPath.section==1){//uncompleted task is completed
        Task *newTask=[self.list.tasks objectAtIndex:indexPath.row];
        if(newTask.recurAfter==-1){
            [self.list.completedTasks addObject:newTask];
    
            NSInteger row=self.list.completedTasks.count-1;
            NSInteger section=0;
            NSArray *array=[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:section]];
            [self.tableView insertRowsAtIndexPaths: array withRowAnimation:UITableViewRowAnimationFade];
        
            [self.list.tasks removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        else{
            NSTimeInterval interval=newTask.recurAfter*60*60*24;
            newTask.due=[NSDate dateWithTimeInterval:interval sinceDate:newTask.due];
        }
        
        [self.navigationController.viewControllers[0] saveLists];
        [self resortCells];
    }
    
    else{//completed task is uncompleted
        Task *newTask=[self.list.completedTasks objectAtIndex:indexPath.row];
        [self.list.tasks addObject:newTask];
        
        NSInteger row=self.list.tasks.count-1;
        NSInteger section=1;
        NSArray *array=[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:section]];
        [self.tableView insertRowsAtIndexPaths: array withRowAnimation:UITableViewRowAnimationFade];
        
        [self.list.completedTasks removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.navigationController.viewControllers[0] saveLists];
        [self resortCells];
        
    }
}

-(void)resortCells{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"due"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    self.list.tasks = [NSMutableArray arrayWithArray:[self.list.tasks sortedArrayUsingDescriptors:sortDescriptors]];
    [self.tableView reloadData];
}
- (IBAction)longCompleteGesture:(UILongPressGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"showCompleted" sender:self];
    
}
@end
