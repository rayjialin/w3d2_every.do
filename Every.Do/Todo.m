//
//  Todo.m
//  Every.Do
//
//  Created by ruijia lin on 4/24/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import "Todo.h"

@implementation Todo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = @"";
        _detail = @"";
        _priorityNumber = @"0";
    }
    return self;
}

-(void)createArray{
}

@end
