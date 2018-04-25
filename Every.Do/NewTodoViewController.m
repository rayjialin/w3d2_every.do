//
//  NewTodoViewController.m
//  Every.Do
//
//  Created by ruijia lin on 4/24/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import "NewTodoViewController.h"

@interface NewTodoViewController ()

@end

@implementation NewTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(todoAdded)];
    self.detailTextView.editable = YES;
    
    
    
    
}

-(void)todoAdded{
    
    TodoArray *todoArray = [TodoArray sharedInstance];
    
    self.todo = [Todo new];
    // writing todo object and pass it back to main VC
    self.todo.title = self.titleLabel.text;
    self.todo.detail = self.detailTextView.text;
    self.todo.deadline = [self.datePicker date];
    self.todo.orderId = todoArray.todoList.count;

    [todoArray.todoList addObject:self.todo];
    
    
    
    [self.navigationController popToRootViewControllerAnimated:true];
}

@end
