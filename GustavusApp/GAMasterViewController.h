//
//  GAMasterViewController.h
//  GustavusApp
//
//  Created by Tucker Saude on 1/8/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GADetailViewController;

@interface GAMasterViewController : UITableViewController

@property (strong, nonatomic) GADetailViewController *detailViewController;

@end
