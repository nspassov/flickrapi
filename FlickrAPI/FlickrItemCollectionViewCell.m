//
//  FlickrItemCollectionViewCell.m
//  FlickrAPI
//
//  Created by Nikolay Spassov on 27.06.16.
//  Copyright © 2016 г. Nikolay Spassov. All rights reserved.
//

#import "FlickrItemCollectionViewCell.h"
#import "AsyncImageView.h"
#import "FlickrItem.h"
#import "Masonry.h"

@interface FlickrItemCollectionViewCell ()

@property (strong, nonatomic) AsyncImageView* photo;

@property (strong, nonatomic) UILabel* author;
@property (strong, nonatomic) UILabel* title;

@end

@implementation FlickrItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.photo];
        [self.contentView addSubview:self.title];
        
        [self setClipsToBounds:true];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.photo setFrame:self.contentView.bounds];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.leading.equalTo(self.contentView.mas_leading);
        make.trailing.equalTo(self.contentView.mas_trailing);
    }];
    
    [super updateConstraints];
}


- (void)setFlickrItem:(FlickrItem *)flickrItem
{
    _flickrItem = flickrItem;
    
    [self.photo setImageURL:[NSURL URLWithString:flickrItem.url]];
    [self.title setText:flickrItem.title];
}


- (AsyncImageView *)photo
{
    if(!_photo) {
        _photo = [[AsyncImageView alloc] init];
        [_photo setContentMode:UIViewContentModeCenter];
    }
    return _photo;
}

- (UILabel *)title
{
    if(!_title) {
        _title = [UILabel new];
        [_title setTextColor:[UIColor blackColor]];
        [_title setFont:[UIFont boldSystemFontOfSize:17]];
        [_title setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:.9]];
    }
    return _title;
}

@end
