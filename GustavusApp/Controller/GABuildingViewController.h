//
//  GABuildingViewController.h
//  GustavusApp
//
//  Created by Tucker Saude on 1/13/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Building.h"
#import "A3ParallaxScrollView.h"
#import "GASourcesViewController.h"


@interface GABuildingViewController : UIViewController <UITextViewDelegate, UITableViewDelegate ,UITableViewDataSource>

@property (strong, nonatomic) Building * building;

- (void)dismissBuildingView;



@end
