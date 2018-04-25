//
//  DetailViewController.h
//  Every.Do
//
//  Created by ruijia lin on 4/24/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface DetailViewController : UIViewController

@property (nonatomic) UITextField *titleLabel;
@property (nonatomic) UITextView *detailTextView;
@property (nonatomic) UIDatePicker *datePicker;
@property (nonatomic) Todo *todo;

-(instancetype)initWithTodo:(Todo *)todo;
@end
