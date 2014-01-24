//
//  GAMasterViewController.h
//  GustavusApp
//
//  Created by Tucker Saude on 1/8/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import <UIKit/UIKit.h>





@interface GAMasterViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView * mapScrollView;
@property (nonatomic, strong) UIImage * gustavusImage;
@property (nonatomic, strong) NSDictionary * buttonInfoDictionary;
@property (nonatomic, strong) UIImageView * gustavusMap;

+(NSArray *)caseArrayforButtons;


@end
