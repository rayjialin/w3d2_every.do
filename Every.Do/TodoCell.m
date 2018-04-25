//
//  TodoCell.m
//  Every.Do
//
//  Created by ruijia lin on 4/24/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import "UIKit/UIKit.h"
#import "TodoCell.h"

@implementation TodoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self){
        self.backgroundColor = [UIColor lightGrayColor];
        self.titleLabel = [UITextField new];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.detailLabel = [UITextField new];
        self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.priorityNumberLabel = [UILabel new];
        self.priorityNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.accessoryType = UITableViewCellAccessoryNone;
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.priorityNumberLabel];
        
        [self setupView];
    }
    
    return self;
}

-(void)setupView{
    
    [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;
    [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.priorityNumberLabel.leadingAnchor constant:-10].active = YES;
    //
    [self.detailLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor].active = YES;
    [self.detailLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10].active = YES;
    [self.detailLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:10].active = YES;
    [self.detailLabel.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor].active = YES;
    //
    [self.priorityNumberLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
    [self.priorityNumberLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10].active = YES;
    [self.priorityNumberLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;
    [self.priorityNumberLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.2].active = YES;
    
}

@end
