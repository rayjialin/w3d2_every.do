//
//  TodoCell.h
//  Every.Do
//
//  Created by ruijia lin on 4/24/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//
#import "UIKit/UIKit.h"
#import <Foundation/Foundation.h>

@interface TodoCell : UITableViewCell

@property (nonatomic) UITextField *titleLabel;
@property (nonatomic) UITextField *detailLabel;
@property (nonatomic) UILabel *priorityNumberLabel;

@end
