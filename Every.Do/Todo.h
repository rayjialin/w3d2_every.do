//
//  Todo.h
//  Every.Do
//
//  Created by ruijia lin on 4/24/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *detail;
@property (nonatomic) NSString *priorityNumber;
@property (nonatomic) NSDate *deadline;
@property (nonatomic) NSInteger orderId;

@end
