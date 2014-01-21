//
//  GAGustavusView.m
//  GustavusApp
//
//  Created by Tucker Saude on 1/8/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import "GAGustavusView.h"
#import "UIImage+PDF.h"
#import "GABuildingViewController.h"
#import "GAMasterViewController.h"

@implementation GAGustavusView

-(id)initWithImage:(UIImage *)image{
    self = [super initWithImage:image];
    if (self) {
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask, YES) objectAtIndex:0];
        plistPath = [rootPath stringByAppendingPathComponent:@"buildingInfo.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            plistPath = [[NSBundle mainBundle] pathForResource:@"buildingInfo" ofType:@"plist"];
        }
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        if (!temp) {
            NSLog(@"Error reading plist: %@, format: %lu", errorDesc, format);
        }
        self.buttonInfoDictionary = temp;
        [self setUpButtons];
    }
    return self;
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    NSLog(@"X location: %f", point.x);
    NSLog(@"Y Location: %f",point.y);
}

-(void)setUpButtons{
    NSLog(@"settingUpButtons");
    if (self.buttonInfoDictionary) {
        for (NSString * key in self.buttonInfoDictionary) {
            NSArray* framePointArray = [self.buttonInfoDictionary[key] objectForKey:@"frameRect"];
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
            
            [self addSubview:button];
            
        }
    }
    else{
        NSLog(@"Button Info Array was not initialized");
    }

    
}

-(IBAction)buttonClicked:(id)sender{
    UIButton * button = (UIButton * )sender;
    NSDictionary*  buttonDict = self.buttonInfoDictionary[[GAGustavusView caseArrayforButtons][button.tag]];
    GAMasterViewController * superview = (GAMasterViewController *)self.superview.superview;
    NSLog(@"%@", [superview class]);
    UIStoryboard * storyboard = superview.storyboard;
    GABuildingViewController * buildingViewController = [storyboard instantiateViewControllerWithIdentifier:@"building"];
    [buildingViewController setName:buttonDict[@"name"]];
    buildingViewController.text = buttonDict[@"text"];
    buildingViewController.pic = buttonDict[@"pic"];
    
    [superview performSegueWithIdentifier:@"building" sender:sender];
    
    
    
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
                      @"convic",
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
                      @"presHouse"];
    }
    return caseArray;
}


@end
