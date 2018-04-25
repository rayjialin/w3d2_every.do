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
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"To-Do List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTodo)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:TodoCell.self forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    self.todoArray = [TodoArray sharedInstance];
    
    Todo *todo = [Todo new];
    todo.title = @"abc";
    todo.detail = @"abababababa";
        todo.priorityNumber = @"0";
    [self.todoArray.todoList addObject:todo];
    
    todo = [Todo new];
    todo.title = @"aldjksj";
    todo.detail = @"asdkjfasdf";
        todo.priorityNumber = @"0";
    [self.todoArray.todoList addObject:todo];
    
    todo = [Todo new];
    todo.title = @"a;qpf:adf";
    todo.detail = @"__________";
        todo.priorityNumber = @"0";
    [self.todoArray.todoList addObject:todo];
    
    todo = [Todo new];
    todo.title = @"21398923";
    todo.detail = @"adsfljvvma,";
        todo.priorityNumber = @"0";
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
//    cell.priorityNumberLabel.text = todo.priorityNumber;
    
    if ([todo.priorityNumber isEqualToString:@"1"]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
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



- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{


    TodoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    Todo *todo = [self.todoArray.todoList objectAtIndex:indexPath.row];
    
    UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Complete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {

        todo.priorityNumber = @"1";
        
        [self.todoArray.completedList addObject:[self.todoArray.todoList objectAtIndex:indexPath.row]];

        [self.todoArray.todoList removeObjectAtIndex:indexPath.row];

        [tableView reloadData];

    }];

    UISwipeActionsConfiguration *actionConfig = [UISwipeActionsConfiguration configurationWithActions:@[action]];
    return actionConfig;
}

-(void)addTodo{
    NewTodoViewController *newTodoVC = [NewTodoViewController new];
    
    [self.navigationController pushViewController:newTodoVC animated:true];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}





@end
