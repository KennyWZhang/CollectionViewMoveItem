//
//  ButtonCollectionViewCell.m
//  iOS9_MoveItem
//
//  Created by Zhangwei on 7/4/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self.name setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
}

@end
