//
//  ViewController.m
//  Every.Do
//
//  Created by ruijia lin on 4/24/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property UITableView *tableView;
@property UISegmentedControl *segmentedControl;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"To-Do List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTodo)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(setTableViewEditable)];
    
    NSArray *segmentArray = [NSArray arrayWithObjects:@"Default", @"Order by Date", nil];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentArray];
    self.segmentedControl.frame = CGRectMake(0, 90, self.view.frame.size.width, 50);
    [self.segmentedControl setSelectedSegmentIndex:0];
    self.segmentedControl.userInteractionEnabled = YES;
    [self.segmentedControl addTarget:self action:@selector(orderByDate:) forControlEvents:UIControlEventValueChanged];
//    [self.segmentedControl targetForAction:@selector(orderByDate:) withSender:self];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:TodoCell.self forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.segmentedControl];
    
    self.todoArray = [TodoArray sharedInstance];
    
    Todo *todo = [Todo new];
    todo.title = @"bbc";
    todo.detail = @"abababababa";
    todo.priorityNumber = @"0";
    todo.orderId = 0;
    [self.todoArray.todoList addObject:todo];
    
    todo = [Todo new];
    todo.title = @"aldjksj";
    todo.detail = @"asdkjfasdf";
    todo.priorityNumber = @"0";
    todo.orderId = 1;
    [self.todoArray.todoList addObject:todo];
    
    todo = [Todo new];
    todo.title = @"a;qpf:adf";
    todo.detail = @"__________";
    todo.priorityNumber = @"0";
    todo.orderId = 2;
    [self.todoArray.todoList addObject:todo];
    
    todo = [Todo new];
    todo.title = @"21398923";
    todo.detail = @"adsfljvvma,";
    todo.priorityNumber = @"0";
    todo.orderId = 3;
    [self.todoArray.todoList addObject:todo];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0){
        return self.todoArray.todoList.count;
    }
    
    return self.todoArray.completedList.count;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Todo *todo;
    if (indexPath.section == 0){
        todo = [self.todoArray.todoList objectAtIndex:indexPath.row];
    }else {
        todo = [self.todoArray.completedList objectAtIndex:indexPath.row];
    }
    
    cell.titleLabel.text = todo.title;
    cell.detailLabel.text = todo.detail;
    cell.deadline.text = [NSDateFormatter localizedStringFromDate:todo.deadline dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    //    cell.priorityNumberLabel.text = todo.priorityNumber;
    
    if ([todo.priorityNumber isEqualToString:@"1"]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return @"To-do Tasks";
    }
    
    return @"Completed Tasks";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Todo *todo = [self.todoArray.todoList objectAtIndex:indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc] initWithTodo:todo];
    
    [self.navigationController pushViewController:detailVC animated:true];
    
}

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Todo *todo = [self.todoArray.todoList objectAtIndex:indexPath.row];
    
    // completion
    if (indexPath.section == 0){
        UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Complete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            
            todo.priorityNumber = @"1";
            
            [self.todoArray.completedList addObject:todo];
            
            [self.todoArray.todoList removeObjectAtIndex:indexPath.row];
            
            [tableView reloadData];
            
        }];
        
        UISwipeActionsConfiguration *actionConfig = [UISwipeActionsConfiguration configurationWithActions:@[action]];
        return actionConfig;
    }
    return NULL;
    
}


- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // deletion
    UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        if (indexPath.section == 0){
            [self.todoArray.todoList removeObjectAtIndex:indexPath.row];
        }else {
            [self.todoArray.completedList removeObjectAtIndex:indexPath.row];
        }
        [tableView reloadData];
    }];
    
    // editable
    UIContextualAction *editAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Edit" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        [tableView reloadData];
    }];
    
    UISwipeActionsConfiguration *actionConfig = [UISwipeActionsConfiguration configurationWithActions:@[action, editAction]];
    return actionConfig;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    Todo *swapSource;
    //    Todo *swapDestination;
    
    if (sourceIndexPath.section != destinationIndexPath.section){
        if (sourceIndexPath.section == 0){
            NSLog(@"hittinaldkfj");
            swapSource = [self.todoArray.todoList objectAtIndex:sourceIndexPath.row];
            swapSource.priorityNumber = @"1";
            [self.todoArray.todoList removeObjectAtIndex:sourceIndexPath.row];
            
            [self.todoArray.completedList insertObject:swapSource atIndex:destinationIndexPath.row];
            //swapDestination = [self.todoArray.completedList objectAtIndex:destinationIndexPath.row];
            
            //swapDestination.priorityNumber = @"1";
        }else{
            NSLog(@"someting");
            
            swapSource = [self.todoArray.completedList objectAtIndex:sourceIndexPath.row];
            swapSource.priorityNumber = @"0";
            [self.todoArray.completedList removeObjectAtIndex:sourceIndexPath.row];
            [self.todoArray.todoList insertObject:swapSource atIndex:destinationIndexPath.row];
            //            swapDestination = [self.todoArray.todoList objectAtIndex:destinationIndexPath.row];
            //            swapDestination.priorityNumber = @"0";
            //            NSLog(@"%@", [[self.todoArray.todoList objectAtIndex:destinationIndexPath.row] priorityNumber]);
            //            NSLog(@"%@", [[self.todoArray.todoList objectAtIndex:self.todoArray.todoList.count- 1] priorityNumber]);
            for (Todo *todo in self.todoArray.todoList){
                NSLog(@"%@", todo.priorityNumber);
            }
        }
        
        
    }
    else if (sourceIndexPath.section == 0){
        [self.todoArray.todoList exchangeObjectAtIndex: sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    }else {
        [self.todoArray.completedList exchangeObjectAtIndex: sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    }
    
    [self.tableView reloadData];
    
    for (Todo *todo in self.todoArray.todoList){
        todo.orderId = [self.todoArray.todoList indexOfObject:todo];
        NSLog(@"%li:  %@", todo.orderId, todo.title);
    }
    for (Todo *todo in self.todoArray.completedList){
        todo.orderId = [self.todoArray.completedList indexOfObject:todo];
        NSLog(@"%li:  %@", todo.orderId, todo.title);
    }
    
    
    
}

-(void)addTodo{
    NewTodoViewController *newTodoVC = [NewTodoViewController new];
    
    [self.navigationController pushViewController:newTodoVC animated:true];
    
}

-(void)setTableViewEditable{
    if (self.tableView.isEditing == YES){
        [self.tableView setEditing:NO];
        for (Todo *todo in self.todoArray.todoList){
            NSLog(@"%@", todo.priorityNumber);
        }
    }else {
        [self.tableView setEditing:YES];
    }
    [self.tableView reloadData];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

-(void)orderByDate:(UISegmentedControl *)sender{
    NSSortDescriptor *sortDescriptor;
    if (sender.selectedSegmentIndex == 0){
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orderId"
                                                     ascending:YES];
    }else {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"deadline"
                                                     ascending:YES];
    }
    self.todoArray.todoList = [NSMutableArray arrayWithArray:[self.todoArray.todoList sortedArrayUsingDescriptors:@[sortDescriptor]]];
    self.todoArray.completedList = [NSMutableArray arrayWithArray:[self.todoArray.completedList sortedArrayUsingDescriptors:@[sortDescriptor]]];
    
    [self.tableView reloadData];
}





@end
