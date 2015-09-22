//
//  GAMasterViewController.m
//  GustavusApp
//
//  Created by Tucker Saude on 1/8/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import "GABuildingManager.h"
#import "GAMasterViewController.h"
#import "UIImage+PDF.h"
#import "GABuildingViewController.h"



@interface GAMasterViewController () {
    
}
@end

@implementation GAMasterViewController {
    UINavigationBar * _navBar;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setting up map
    CGRect screenRect = self.view.bounds;
    self.gustavusMap = [[UIImageView alloc]initWithImage:[UIImage imageWithPDFNamed:@"gustavus.pdf"
                                                                           atHeight:800.0]];
    self.gustavusMap.userInteractionEnabled = YES;
    self.mapScrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    [self.mapScrollView addSubview:self.gustavusMap];
    [self.mapScrollView setContentSize:self.gustavusMap.bounds.size];
    self.mapScrollView.minimumZoomScale = .5;
    self.mapScrollView.maximumZoomScale = 3;
    self.mapScrollView.delegate = self;

    [self setUpButtons];
    
    [self.view addSubview:self.mapScrollView];
    [self.view addSubview:_navBar];
    
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.gustavusMap;
}

-(void)setUpButtons {
    if ([[GABuildingManager sharedManager] buildingInfo]) {
        for (NSString * key in [[GABuildingManager sharedManager] buildingInfo]) {
            NSArray* framePointArray = [[[GABuildingManager sharedManager] buildingInfo][key] objectForKey:@"frameRect"];
            UIButton * button;
            button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setFrame:CGRectMake([(NSNumber*)framePointArray[0] floatValue], [(NSNumber*)framePointArray[1] floatValue], [(NSNumber*)framePointArray[2] floatValue], [(NSNumber*)framePointArray[3] floatValue])];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:self action:@selector(buttonHeld:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:self action:@selector(buttonLetGo:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchDragOutside];
            [button setTag:[(NSNumber*)framePointArray[4] intValue]-1];
            CALayer * layer = [button layer];
            [layer setMasksToBounds:YES];
            [layer setCornerRadius:10.0]; //when radius is 0, the border is a rectangle
            [layer setBorderWidth:1.0];
            [layer setBorderColor:[[UIColor grayColor] CGColor]];
            
            [self.gustavusMap addSubview:button];
            
        }
    }
    else {
        NSLog(@"Button Info Array was not initialized");
    }
}

-(IBAction)buttonLetGo:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor clearColor]];
}

-(IBAction)buttonHeld:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
}

-(IBAction)buttonClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor clearColor]];
    
    Building *building = [[Building alloc]initWithName:[GAMasterViewController caseArrayforButtons][button.tag]];
    UIStoryboard *storyboard = self.storyboard;
    UINavigationController *navigationController =(UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"buildingViewController"];
    
    GABuildingViewController *buildingViewController;
    
    if([[navigationController topViewController] isKindOfClass:[GABuildingViewController class]]) {
        buildingViewController = (GABuildingViewController *)[navigationController topViewController];
        [buildingViewController setBuilding:building];
    }
    else {
        NSLog(@"top controller is not GABuildingViewController");
    }

    [self presentViewController:navigationController animated:YES completion:nil];
}

+(NSArray *)caseArrayforButtons {
    static NSArray* caseArray = nil;
    
    if(caseArray == nil) {
        caseArray = @[@"arb",
                      @"arborview",
                      @"cabin",
                      @"sfaArt",
                      @"sfaMusic",
                      @"sfaTheater",
                      @"paMatHall",
                      @"prairieView",
                      @"southwest",
                      @"nobel",
                      @"con",
                      @"pittman",
                      @"sohre",
                      @"andersonHall",
                      @"rundstrom",
                      @"oldMain",
                      @"chapel",
                      @"olin",
                      @"carlson",
                      @"lib",
                      @"studU",
                      @"campusCenter",
                      @"lund",
                      @"football",
                      @"collegeView",
                      @"coed",
                      @"uhler",
                      @"admin",
                      @"north",
                      @"gibbs",
                      @"sorenson",
                      @"presHouse",
                      @"beck",
                      @"vic"];
    }
    return caseArray;
}

@end
