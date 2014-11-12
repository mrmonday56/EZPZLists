//
//  taskViewController.m
//  EZPZLists
//
//  Created by krcox1 on 11/3/14.
//  Copyright (c) 2014 krcox1. All rights reserved.
//

#import "taskViewController.h"

@interface taskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextView *detailField;
@property (weak, nonatomic) IBOutlet UITextField *recurField;

@end

@implementation taskViewController

-(IBAction)saveNewTask :(id)sender {
    self.task.name=self.nameField.text;
    self.task.detail=self.detailField.text;
    self.task.due=self.duePicker.date;
    
    NSInteger recur= self.recurField.text.integerValue;
    if(recur<1)
        recur=-1;
    self.task.recurAfter=recur;
    
    [self.navigationController.viewControllers[0] saveLists];
    
    //[self.master saveLists];
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameField.text=self.task.name;
    self.detailField.text=self.task.detail;
    self.duePicker.date=self.task.due;
    self.recurField.text=[NSString stringWithFormat:@"%ld days",(long)self.task.recurAfter];
    
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
