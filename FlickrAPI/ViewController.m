//
//  ViewController.m
//  FlickrAPI
//
//  Created by Nikolay Spassov on 27.06.16.
//  Copyright © 2016 г. Nikolay Spassov. All rights reserved.
//

#import "ViewController.h"
#import "FlickrCollectionViewFlowLayoutController.h"

@interface ViewController ()

@property (strong, nonatomic) FlickrCollectionViewFlowLayoutController* collectionViewController;

@end

@implementation ViewController

- (FlickrCollectionViewFlowLayoutController *)collectionViewController
{
    if(!_collectionViewController) {
        _collectionViewController = [FlickrCollectionViewFlowLayoutController collectionViewFlowLayoutController];
    }
    return _collectionViewController;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addChildViewController:self.collectionViewController];
    [self.view addSubview:self.collectionViewController.view];
    [self.collectionViewController didMoveToParentViewController:self];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.collectionViewController.view setFrame:self.view.bounds];
}

@end
