//
//  ViewController.h
//  Every.Do
//
//  Created by ruijia lin on 4/24/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"
#import "TodoCell.h"
#import "TodoArray.h"
#import "DetailViewController.h"
#import "NewTodoViewController.h"
//@class NewTodoViewController;

@interface ViewController : UIViewController

@property (nonatomic, strong) TodoArray *todoArray;
@end

