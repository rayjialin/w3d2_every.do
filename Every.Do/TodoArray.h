//
//  TodoArray.h
//  Every.Do
//
//  Created by ruijia lin on 4/24/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Todo.h"

@interface TodoArray : NSObject

@property (nonatomic, strong) NSMutableArray *todoList;
@property (nonatomic, strong) NSMutableArray *completedList;
+ (instancetype)sharedInstance;
@end
