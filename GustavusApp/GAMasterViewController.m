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

@implementation GAMasterViewController{
    UINavigationBar * _navBar;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //nav bar
    _navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    [_navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
     _navBar.shadowImage = [UIImage new];
    [_navBar setBarTintColor:[UIColor darkTextColor]];
    _navBar.translucent = YES;
    UINavigationItem * titleItem = [[UINavigationItem alloc] initWithTitle:@"map"];
    _navBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    _navBar.items = @[titleItem];
    
    //setting up map
    CGRect screenRect = self.view.bounds;
    self.gustavusMap = [[UIImageView alloc]initWithImage:[UIImage imageWithPDFNamed:@"gustavus.pdf"
                                                                           atHeight:800.0]];
    [self.gustavusMap setUserInteractionEnabled:YES];
    self.mapScrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    //[scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.mapScrollView addSubview:self.gustavusMap];
    [self.mapScrollView setContentSize:self.gustavusMap.bounds.size];
    self.mapScrollView.minimumZoomScale = .5;
    self.mapScrollView.maximumZoomScale = 3;
    self.mapScrollView.delegate = self;

    [self setUpButtons];
    
    [self.view addSubview:self.mapScrollView];
    [self.view addSubview:_navBar];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"building"]) {
        UIButton * button = (UIButton * )sender;
        
        NSLog(@"button clicked %ld", (long)button.tag);
        Building * building = [[Building alloc]initWithName:[GAMasterViewController caseArrayforButtons][button.tag]];
        NSLog(@"%@", building.title);
        
        [segue.destinationViewController setBuilding:building];
    }
}



-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.gustavusMap;
}

-(void)setUpButtons{
    NSLog(@"settingUpButtons");
    if ([[GABuildingManager sharedManager] buildingInfo]) {
        for (NSString * key in [[GABuildingManager sharedManager] buildingInfo]) {
            NSArray* framePointArray = [[[GABuildingManager sharedManager] buildingInfo][key] objectForKey:@"frameRect"];
            UIButton * button;
            button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setFrame:CGRectMake([(NSNumber*)framePointArray[0] floatValue], [(NSNumber*)framePointArray[1] floatValue], [(NSNumber*)framePointArray[2] floatValue], [(NSNumber*)framePointArray[3] floatValue])];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [button setTag:[(NSNumber*)framePointArray[4] intValue]-1];
            CALayer * layer = [button layer];
            [layer setMasksToBounds:YES];
            [layer setCornerRadius:0.0]; //when radius is 0, the border is a rectangle
            [layer setBorderWidth:1.0];
            [layer setBorderColor:[[UIColor grayColor] CGColor]];
            
            [self.gustavusMap addSubview:button];
            
        }
    }
    else{
        NSLog(@"Button Info Array was not initialized");
    }
    
    
}


-(IBAction)buttonClicked:(id)sender{
    UIButton * button = (UIButton * )sender;
    
    NSLog(@"button clicked %ld", (long)button.tag);
    Building * building = [[Building alloc]initWithName:[GAMasterViewController caseArrayforButtons][button.tag]];
    NSLog(@"%@", building.title);
    UIStoryboard * storyboard = self.storyboard;
    GABuildingViewController * buildingViewController =(GABuildingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"buildingViewController"];
    [buildingViewController setBuilding:building];
    [self presentViewController:buildingViewController animated:YES completion:nil];
}


+(NSArray *)caseArrayforButtons{
    static NSArray* caseArray = nil;
    
    if(caseArray == nil){
        caseArray = @[@"arb",
                      @"arborview",
                      @"cabin",
                      @"sfaArt",
                      @"sfaMusic",
                      @"sfaTheater",
                      @"paMatHall",
                      @"prarieView",
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
                      @"soccer",
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
