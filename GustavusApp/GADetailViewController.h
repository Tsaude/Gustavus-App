//
//  GADetailViewController.h
//  GustavusApp
//
//  Created by Tucker Saude on 1/8/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GADetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
