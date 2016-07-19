//
//  ViewController.m
//  iOS9_MoveItem
//
//  Created by Zhangwei on 6/26/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "ViewController.h"
#import "LabelCell.h"
#import "KwzFlowLayout.h"
#import "LabelCell.h"
#import "ButtonCell.h"
#import "TextFieldCell.h"

@interface ViewController ()<UICollectionViewDelegateFlowLayout,
                             UICollectionViewDataSource,
                             UICollectionViewDelegate,
                             TextFieldCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) KwzFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *to;

@property (nonatomic, strong) NSMutableArray *cc;

@property (nonatomic, strong) NSMutableArray *bcc;


@property (nonatomic, strong) NSString *temp;

@property (nonatomic, assign) BOOL textFieldIsEditting;

@end

@implementation ViewController

static NSString *const reuseIdentifierButton = @"ButtonCell";

static NSString *const reuseIdentifierLabel = @"LabelCell";

static NSString *const reuseIdentifierTextField = @"TextFieldCell";

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.to addObject:@"1"];
    [self.to addObject:@"123213"];
    [self.to addObject:@"3431423421343241324"];
    [self.to addObject:@"14343"];
    [self.to addObject:@"1431241324124132412431212"];
    [self.to addObject:@"34343"];
    [self.to addObject:@"3431423421343241324"];
    [self.to addObject:@"1431241324124132412431212"];
    [self.to addObject:@"34343"];

    [self.cc addObject:@"3413243324"];
    [self.cc addObject:@"1434"];
    [self.cc addObject:@"14314"];
    [self.cc addObject:@"1431241324124132412431212"];
    [self.cc addObject:@"14314"];
    [self.cc addObject:@"143141"];

    [self.bcc addObject:@"1431241324124132412431212"];
    [self.bcc addObject:@"1431"];
    [self.bcc addObject:@"1431413413413241"];
    [self.bcc addObject:@"23414113241"];
    [self.bcc addObject:@"141324124132412412123431231432"];
    [self.bcc addObject:@"1431243124123431"];

    self.layout = [[KwzFlowLayout alloc] init];
    self.layout.minimumLineSpacing = 10;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:self.layout];

    self.collectionView.delegate = self;

    self.collectionView.dataSource = self;

    [self.view addSubview:self.collectionView];

    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifierButton bundle:nil]
          forCellWithReuseIdentifier:reuseIdentifierButton];
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifierLabel bundle:nil]
          forCellWithReuseIdentifier:reuseIdentifierLabel];
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifierTextField bundle:nil]
          forCellWithReuseIdentifier:reuseIdentifierTextField];

    // 此处给其增加长按手势，用此手势触发cell移动效果
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
    [self.collectionView addGestureRecognizer:longGesture];

    self.collectionView.backgroundColor = [UIColor lightGrayColor];

    self.temp = @"1";

    self.textFieldIsEditting = NO;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.to.count + 2;
    } else if (section == 1) {
        return self.cc.count + 2;
    } else if (section == 2) {
        return self.bcc.count + 2;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {
            LabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierLabel
                                                                        forIndexPath:indexPath];
            cell.name.text = @"收件人：";
             return cell;
        } else if (row <= self.to.count) {
            ButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierButton
                                                                         forIndexPath:indexPath];
            [cell.name setTitle:self.to[row - 1] forState:UIControlStateNormal];
            return cell;
        } else if (row == self.to.count + 1) {
            TextFieldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierTextField
                                                                            forIndexPath:indexPath];
            cell.name.text = @"1";
            cell.delegate = self;

            [cell.name addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];

            return cell;
        }
    } else if (section == 1) {
        if (row == 0) {
            LabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierLabel forIndexPath:indexPath];
            cell.name.text = @"抄送：";
            return cell;
        } else if (row <= self.cc.count) {
            ButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierButton forIndexPath:indexPath];
            [cell.name setTitle:self.cc[row - 1] forState:UIControlStateNormal];
            return cell;
        } else if (row == self.cc.count + 1) {
            TextFieldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierTextField forIndexPath:indexPath];
            cell.name.text = @"this is text field.";
            return cell;
        }
    } else if (section == 2) {
        if (row == 0) {
            LabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierLabel forIndexPath:indexPath];
            cell.name.text = @"密送：";
            return cell;
        } else if (row <= self.bcc.count) {
            ButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierButton forIndexPath:indexPath];
            [cell.name setTitle:self.bcc[row - 1] forState:UIControlStateNormal];
            return cell;
        } else if (row == self.bcc.count + 1) {
            TextFieldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierTextField forIndexPath:indexPath];
            cell.name.text = @"this is text field.";
            return cell;
        }
    }

    return nil;
}


- (void)textChanged:(id)sender
{
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture
{
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView
canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;

    if (section == 0 || section == 1 || section == 2) {
        if (row == 0 || row == self.to.count + 1) {
            return NO;
        }
    }

    // 返回YES允许其item移动
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
   moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath
           toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSLog(@"(%ld, %ld) -> (%ld, %ld)", (long)sourceIndexPath.section, (long)sourceIndexPath.row, (long)destinationIndexPath.section, (long)destinationIndexPath.row);

    NSMutableArray *sourceArray;
    switch (sourceIndexPath.section) {
        case 0:
            sourceArray = self.to;
            break;
        case 1:
            sourceArray = self.cc;
            break;
        case 2:
            sourceArray = self.bcc;
            break;
        default:
            break;
    }
    NSString *address = [sourceArray objectAtIndex:sourceIndexPath.row - 1];
    [sourceArray removeObjectAtIndex:sourceIndexPath.row - 1];

    NSMutableArray *destinationArray;
    switch (destinationIndexPath.section) {
        case 0:
            destinationArray = self.to;
            break;
        case 1:
            destinationArray = self.cc;
            break;
        case 2:
            destinationArray = self.bcc;
            break;
        default:
            break;
    }
    [destinationArray insertObject:address atIndex:destinationIndexPath.row - 1];

    /*
    if (destinationIndexPath.section == 0) {
        NSString *address;
        switch (sourceIndexPath.section) {
            case 0:
                address = [self.to objectAtIndex:sourceIndexPath.row - 1];
                [self.to removeObjectAtIndex:sourceIndexPath.row - 1];
                [self.to insertObject:address atIndex:destinationIndexPath.row - 1];
                break;
            case 1:
                address = [self.cc objectAtIndex:sourceIndexPath.row - 1];
                [self.cc removeObjectAtIndex:sourceIndexPath.row - 1];
                [self.to insertObject:address atIndex:destinationIndexPath.row - 1];
                break;
            case 2:
                address = [self.bcc objectAtIndex:sourceIndexPath.row - 1];
                [self.bcc removeObjectAtIndex:sourceIndexPath.row - 1];
                [self.to insertObject:address atIndex:destinationIndexPath.row - 1];
                break;
            default:
                break;
        }
    } else if (destinationIndexPath.section == 1) {
        NSString *address;
        switch (sourceIndexPath.section) {
            case 0:
                address = [self.to objectAtIndex:sourceIndexPath.row - 1];
                [self.to removeObjectAtIndex:sourceIndexPath.row - 1];
                [self.cc insertObject:address atIndex:destinationIndexPath.row - 1];
                break;
            case 1:
                address = [self.cc objectAtIndex:sourceIndexPath.row - 1];
                [self.cc removeObjectAtIndex:sourceIndexPath.row - 1];
                [self.cc insertObject:address atIndex:destinationIndexPath.row - 1];
                break;
            case 2:
                address = [self.bcc objectAtIndex:sourceIndexPath.row - 1];
                [self.bcc removeObjectAtIndex:sourceIndexPath.row - 1];
                [self.cc insertObject:address atIndex:destinationIndexPath.row - 1];
                break;
            default:
                break;
        }
    } else if (destinationIndexPath.section == 2) {
        NSString *address;
        switch (sourceIndexPath.section) {
            case 0:
                address = [self.to objectAtIndex:sourceIndexPath.row - 1];
                [self.to removeObjectAtIndex:sourceIndexPath.row - 1];
                [self.bcc insertObject:address atIndex:destinationIndexPath.row - 1];
                break;
            case 1:
                address = [self.cc objectAtIndex:sourceIndexPath.row - 1];
                [self.cc removeObjectAtIndex:sourceIndexPath.row - 1];
                [self.bcc insertObject:address atIndex:destinationIndexPath.row - 1];
                break;
            case 2:
                address = [self.bcc objectAtIndex:sourceIndexPath.row - 1];
                [self.bcc removeObjectAtIndex:sourceIndexPath.row - 1];
                [self.bcc insertObject:address atIndex:destinationIndexPath.row - 1];
                break;
            default:
                break;
        }
    }
    */

    [collectionView.collectionViewLayout invalidateLayout];
}

-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout
 sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize;

    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {
            return CGSizeMake(80, 50);
        } else if (row <= self.to.count) {
            NSString *string = self.to[indexPath.row - 1];
            return CGSizeMake([string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 50)
                                                   options:NSStringDrawingUsesDeviceMetrics
                                                attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}
                                                   context:nil].size.width, 50);
        } else if (row == self.to.count + 1) {
            if (self.textFieldIsEditting == YES) {
                itemSize = CGSizeMake([self.temp boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 50.0f)
                                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                                       attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}
                                                          context:nil].size.width + 10, 50);
            } else {
                itemSize = CGSizeMake([self.temp boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 50.0f)
                                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                                       attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}
                                                          context:nil].size.width + 2, 50);
            }
        }
    } else if (section == 1) {
        if (row == 0) {
            return CGSizeMake(80, 50);
        } else if (row <= self.cc.count) {
            NSString *string = self.cc[indexPath.row - 1];
            itemSize = CGSizeMake([string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 50)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}
                                                   context:nil].size.width, 50);
        } else if (row == self.cc.count + 1) {
            itemSize = CGSizeMake([@"this is text field." boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 50)
                                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                                       attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}
                                                                          context:nil].size.width, 50);
        }
    } else if (section == 2) {
        if (row == 0) {
            return CGSizeMake(80, 50);
        } else if (row <= self.bcc.count) {
            NSString *string = self.bcc[indexPath.row - 1];
            itemSize = CGSizeMake([string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 50)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}
                                                   context:nil].size.width, 50);
        } else if (row == self.bcc.count + 1) {
            itemSize = CGSizeMake([@"this is text field." boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 50)
                                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                                       attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}
                                                                          context:nil].size.width, 50);
        }
    }

    NSLog(@"%@%@", @"sizeForItemAtIndexPath:", NSStringFromCGSize(itemSize));

    return itemSize;
}

#pragma mark - TextFieldCellDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    self.temp = [NSString stringWithFormat:@"%@%@", textField.text, string];

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.textFieldIsEditting = YES;

    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.textFieldIsEditting = NO;

    [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - lazy initialization

- (NSMutableArray *)to
{
    if (_to == nil) {
        _to = [NSMutableArray array];
    }
    return _to;
}

- (NSMutableArray *)cc
{
    if (_cc == nil) {
        _cc = [NSMutableArray array];
    }
    return _cc;
}

- (NSMutableArray *)bcc
{
    if (_bcc == nil) {
        _bcc = [NSMutableArray array];
    }
    return _bcc;
}

@end
