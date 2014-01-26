//
//  GAImageTileView.m
//  GustavusApp
//
//  Created by Tucker Saude on 1/23/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import "GAImageTileView.h"

@interface GAImageTileView ()
@property (strong, nonatomic) UIImageView * imageView;
@end

@implementation GAImageTileView


- (void)setImage:(UIImage *)image
{
    if (!self.imageView) {
        //self.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.];
        //CGRect frame = self.bounds;
        //frame.origin = CGPointMake(0.5, 0.5);
        //frame.size.width -= 1.;
        //frame.size.height -= 1.;
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
    }
    self.imageView.image = image;
}

@end
