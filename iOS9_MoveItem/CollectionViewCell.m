//
//  CollectionViewCell.m
//  iOS9_MoveItem
//
//  Created by Zhangwei on 6/26/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    UICollectionViewLayoutAttributes *collectionViewLayoutAttributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    if (collectionViewLayoutAttributes.indexPath.row % 2 == 0) {
        CGSize newSize = collectionViewLayoutAttributes.size;
        CGPoint newCenter = collectionViewLayoutAttributes.center;

        newSize.width = 80; // change the width from 50 to 100
        newCenter.x = 40; // change the center.x from 25 to 50

        collectionViewLayoutAttributes.size = newSize;
        collectionViewLayoutAttributes.center = newCenter;
    } else {
        CGSize newSize = collectionViewLayoutAttributes.size;
        CGPoint newCenter = collectionViewLayoutAttributes.center;

        newSize.width = 50;
        newCenter.x = 25;

        collectionViewLayoutAttributes.size = newSize;
        collectionViewLayoutAttributes.center = newCenter;
    }

    return collectionViewLayoutAttributes;

}

- (void)prepareForReuse
{
    [super prepareForReuse];

    self.backgroundColor = [UIColor blueColor];
}

- (void)layoutSubviews
{
    if (self.indexPath.row % 2 == 0) {
        CGSize newSize = self.contentView.bounds.size;
        CGPoint newCenter = self.contentView.center;

        newSize.width = 80; // change the width from 50 to 100
        newCenter.x = 40; // change the center.x from 25 to 50

        self.contentView.bounds = CGRectMake(0, 0, newSize.width, newSize.height);
        self.contentView.center = newCenter;
    } else {
        CGSize newSize = self.contentView.bounds.size;
        CGPoint newCenter = self.contentView.center;

        newSize.width = 50; // change the width from 50 to 100
        newCenter.x = 25; // change the center.x from 25 to 50

        self.contentView.bounds = CGRectMake(0, 0, newSize.width, newSize.height);
        self.contentView.center = newCenter;
    }
}



@end
