//
//  MasterViewController.m
//  EZPZLists
//
//  Created by krcox1 on 10/27/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import "MasterViewController.h"


@interface MasterViewController ()
@property NSMutableArray *lists;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self loadLists];

    /*UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
     master default code
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)addList:(list*) newList{
    [self.lists addObject:newList];
    [self saveLists];
}

-(NSString*)documentsDirectory
{
    return [@"~/Documents" stringByExpandingTildeInPath];
}

-(NSString*)dataFilePath
{
    return [[self documentsDirectory]stringByAppendingPathComponent:@"lists.plist"];
}

-(void)loadLists
{
    if([[NSFileManager defaultManager]fileExistsAtPath:[self dataFilePath]])
    {
        NSData *data=[[NSData alloc]initWithContentsOfFile:[self dataFilePath]];
        NSKeyedUnarchiver *a=[[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        self.lists=[a decodeObjectForKey:@"lists"];
        [a finishDecoding];
    }
    else
    {
        self.lists=[[NSMutableArray alloc]init];
    }
}

-(void)saveLists
{
    NSMutableData *data=[[NSMutableData alloc] init];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:self.lists forKey:@"lists"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:true];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        list *list = self.lists[indexPath.row];
        [[segue destinationViewController] setList:list];
        
    }
    if ([[segue identifier] isEqualToString:@"newList"]) {
        newListViewController *nextView=segue.destinationViewController;
        nextView.parent=self;
    }
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    list *list = self.lists[indexPath.row];
    cell.textLabel.text = list.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.lists removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
@end

