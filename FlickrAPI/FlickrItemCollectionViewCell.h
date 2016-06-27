//
//  FlickrItemCollectionViewCell.h
//  FlickrAPI
//
//  Created by Nikolay Spassov on 27.06.16.
//  Copyright © 2016 г. Nikolay Spassov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlickrItem;

@interface FlickrItemCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) FlickrItem* flickrItem;

@end
