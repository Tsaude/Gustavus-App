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

#import "PDFScrollView.h"


@interface GAMasterViewController () {
    
}
@end

@implementation GAMasterViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];

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

    
    
}






-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    NSLog(@"X location: %f", point.x);
    NSLog(@"Y Location: %f",point.y);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"building"]) {
        UIButton * button = (UIButton * )sender;
        
        NSLog(@"button clicked %ld", (long)button.tag);
        Building * building = [[Building alloc]initWithName:[GAMasterViewController caseArrayforButtons][button.tag]];
        NSLog(@"%@", building.title);
//        UIStoryboard * storyboard = self.storyboard;
//        GABuildingViewController * buildingViewController =(GABuildingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"buildingViewController"];

        [segue.destinationViewController setBuilding:building];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    //[self.navigationController setNavigationBarHidden:YES];
    
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.translucent= YES;
    
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
            NSLog(@"%@" ,key);
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

    [self performSegueWithIdentifier: @"building" sender: sender];
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
