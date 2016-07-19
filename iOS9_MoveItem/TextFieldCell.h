//
//  TextFieldCell.h
//  iOS9_MoveItem
//
//  Created by Zhangwei on 7/4/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TextFieldCell;

@protocol TextFieldCellDelegate <NSObject>

@optional

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;

- (void)textFieldDidBeginEditing:(UITextField *)textField;

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;

- (void)textFieldDidEndEditing:(UITextField *)textField;

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end

@interface TextFieldCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (nonatomic, weak) id<TextFieldCellDelegate> delegate;

@end
