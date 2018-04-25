//
//  TodoArray.m
//  Every.Do
//
//  Created by ruijia lin on 4/24/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import "TodoArray.h"

@implementation TodoArray


+ (instancetype)sharedInstance
{
    static TodoArray *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TodoArray alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.todoList = [NSMutableArray new];
        self.completedList = [NSMutableArray new];
    }
    return self;
}
@end
