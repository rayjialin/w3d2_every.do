//
//  DetailViewController.m
//  Every.Do
//
//  Created by ruijia lin on 4/24/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

-(instancetype)initWithTodo:(Todo *)todo{
    self = [super init];
    if (self) {
        self.todo = todo;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [UITextField new];
    self.titleLabel.backgroundColor = [UIColor lightGrayColor];
    self.titleLabel.text = self.todo.title;
    self.detailTextView = [UITextView new];
    self.detailTextView.text = self.todo.detail;
    self.detailTextView.backgroundColor = [UIColor darkGrayColor];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailTextView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.detailTextView];
    
    [self setupView];
}

-(void)setupView{
    
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    [self.titleLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    [self.titleLabel.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.05].active = YES;
    
    [self.detailTextView.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:20].active = YES;
    [self.detailTextView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-60].active = YES;
    
    [self.detailTextView.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor].active = YES;
    [self.detailTextView.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor].active = YES;
}

@end
