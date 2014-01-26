//
//  GABuildingImagesViewController.h
//  GustavusApp
//
//  Created by Tucker Saude on 1/23/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DARecycledScrollView.h"
#import "DARecycledTileView.h"
#import "GAImageTileView.h"

@interface GABuildingImagesViewController : UIViewController <DARecycledScrollViewDataSource>

@property (strong, nonatomic) NSArray *images;
@property (readonly, strong, nonatomic) DARecycledScrollView *scrollView;

@end
