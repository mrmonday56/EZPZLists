//
//  newTaskViewController.m
//  EZPZLists
//
//  Created by krcox1 on 11/2/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import "newTaskViewController.h"

@interface newTaskViewController ()

@property (weak, nonatomic) IBOutlet UITextField *recurField;
@end

@implementation newTaskViewController

-(IBAction)saveNewTask :(id)sender {
    Task *newTask=[[Task alloc] init];
    newTask.name=self.nameField.text;
    newTask.detail=self.detailTextView.text;
    newTask.due=self.dueDatePicker.date;
    
    
    NSInteger recur= self.recurField.text.integerValue;
    if(recur<1)
        recur=-1;
    newTask.recurAfter=recur;
    
    [self.parentList addTask:newTask];
    
    [self.navigationController.viewControllers[0] saveLists];
    
    //[self.master saveLists];
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNewTask:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
