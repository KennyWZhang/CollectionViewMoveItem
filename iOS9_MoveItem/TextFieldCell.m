//
//  TextFieldCell.m
//  iOS9_MoveItem
//
//  Created by Zhangwei on 7/4/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "TextFieldCell.h"

@interface TextFieldCell ()<UITextFieldDelegate>

@end

@implementation TextFieldCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code

    self.name.delegate = self;

//    self
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldShouldBeginEditing:");
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{

    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:self.name];
    }


    NSLog(@"textFieldDidBeginEditing:");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
     NSLog(@"textFieldShouldEndEditing:");
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{

    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:self.name];
    }

    NSLog(@"textFieldDidEndEditing:");
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSLog(@"%@ %lu %lu %@", textField.text, (unsigned long)range.location, (unsigned long)range.length, string);

    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }

    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn:");
    return YES;
}


//-(void)layoutSubviews
//{
//    [self sizeToFit];
//}

@end
