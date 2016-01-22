//
//  Cell1.m
//  AddTableViewCell
//
//  Created by macbook on 16/1/4.
//  Copyright © 2016年 DLD. All rights reserved.
//

#import "Cell.h"

@implementation Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor yellowColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.isOpen = NO;
    self.isAddCell = NO;
    return self;
}

@end
