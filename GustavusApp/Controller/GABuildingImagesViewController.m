//
//  GABuildingImagesViewController.m
//  GustavusApp
//
//  Created by Tucker Saude on 1/23/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//



#import "GABuildingImagesViewController.h"

@interface GABuildingImagesViewController ()

@property (strong, nonatomic) IBOutlet DARecycledScrollView *scrollView;

@end

@implementation GABuildingImagesViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.scrollView.dataSource = self;
    self.images = @[[UIImage imageNamed:@"1.jpg"],
                    [UIImage imageNamed:@"2.jpg"],
                    [UIImage imageNamed:@"3.jpg"],
                    [UIImage imageNamed:@"4.jpg"],
                    [UIImage imageNamed:@"5.jpg"],
                    [UIImage imageNamed:@"6.jpg"],
                    [UIImage imageNamed:@"7.jpg"],
                    [UIImage imageNamed:@"8.jpg"],
                    [UIImage imageNamed:@"9.jpg"],
                    [UIImage imageNamed:@"10.jpg"]];
}

- (void)setImages:(NSArray *)images
{
    if (_images != images) {
        _images = images;
        [self.scrollView reloadData];
    }
}


- (NSInteger)numberOfTilesInScrollView:(DARecycledScrollView *)scrollView
{
    return self.images.count;
}

- (void)recycledScrollView:(DARecycledScrollView *)scrollView configureTileView:(DARecycledTileView *)tileView forIndex:(NSUInteger)index
{
    [(GAImageTileView *)tileView setImage:self.images[index]];
}

- (DARecycledTileView *)tileViewForRecycledScrollView:(DARecycledScrollView *)scrollView
{
    GAImageTileView *tileView = (GAImageTileView *)[scrollView dequeueRecycledTileView];
    if (!tileView) {
        tileView = [[GAImageTileView alloc] initWithFrame:CGRectMake(0., 0., 100., CGRectGetHeight(scrollView.frame))];
        tileView.displayRecycledIndex = NO;
    }
    return tileView;
}

- (CGFloat)widthForTileAtIndex:(NSInteger)index scrollView:(DARecycledScrollView *)scrollView
{
    UIImage *image = self.images[index];
    return image.size.width;
}


@end
