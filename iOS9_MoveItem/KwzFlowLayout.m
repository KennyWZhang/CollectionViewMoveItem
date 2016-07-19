//
//  KwzFlowLayout.m
//  iOS9_MoveItem
//
//  Created by Zhangwei on 7/4/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "KwzFlowLayout.h"

@implementation KwzFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"%@%@", @"layoutAttributesForElementsInRect:", NSStringFromCGRect(rect));

    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];

    for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
        NSLog(@"%@", attributes.indexPath);
        NSLog(@"%@", NSStringFromCGRect(attributes.frame));
        NSLog(@"%@", NSStringFromCGPoint(attributes.center));

        if (attributes.indexPath.row == [self.collectionView numberOfItemsInSection:attributes.indexPath.section] - 1
            && attributes.indexPath.section == 0) {
            if (attributes.frame.origin.x + attributes.frame.size.width + [self sectionInset].right > [self collectionViewContentSize].width) {
                attributes.frame = CGRectMake(attributes.frame.origin.x, attributes.frame.origin.y, self.collectionViewContentSize.width - self.sectionInset.right - attributes.frame.origin.x, 50);
            }
        }
    }

    return attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@%@", @"layoutAttributesForItemAtIndexPath:", indexPath);

    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];

    NSLog(@"%@", NSStringFromCGRect(attributes.frame));

    return attributes;
}

@end
