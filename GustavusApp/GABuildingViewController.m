//
//  GABuildingViewController.m
//  GustavusApp
//
//  Created by Tucker Saude on 1/13/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import "A3ParallaxScrollView.h"
#import "GABuildingViewController.h"

@interface GABuildingViewController ()


@property (weak, nonatomic) IBOutlet A3ParallaxScrollView *scrollView;


@end

@implementation GABuildingViewController{
    UITextView * _textView;
    UINavigationBar * _navBar;
}

-(void)viewWillAppear:(BOOL)animated{
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //building Navigation Bar
    
    _navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    [_navBar setBarTintColor:[UIColor darkTextColor]];
    _navBar.translucent = YES;
    UIBarButtonItem * back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismissBuildingView)];
    UINavigationItem * titleItem = [[UINavigationItem alloc] initWithTitle:self.building.title];
    [titleItem setLeftBarButtonItem:back];
    _navBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    _navBar.items = @[titleItem];
    [self.view addSubview:_navBar];
    
    
    //getting image
    UIImage * image;


    image = [UIImage imageNamed:@"oldMain.png"];
    NSLog(@"%@", image);
    if(!image){
        
        
        image = [UIImage imageNamed:@"Chapel-Winter.png"];
        NSLog(@"%@", image);
        
        
    }

    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    
    
    //building the UITextView
    NSString * path = [[NSBundle mainBundle]pathForResource:@"sample" ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];

    NSAttributedString * contentAttr = [[NSAttributedString alloc] initWithString:content
                                                                       attributes: @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                                                          NSForegroundColorAttributeName: [UIColor blackColor]}];
    CGSize textSize = [contentAttr size];

    _textView= [[UITextView alloc] initWithFrame:CGRectMake(0, (imageView.frame.size.height*.75), [[UIScreen mainScreen] bounds].size.width, textSize.height)];
    [_textView setAttributedText:contentAttr];
    [_textView setDelegate:self];
    [_textView setScrollEnabled:NO];
    [_textView setUserInteractionEnabled:NO];
    [_textView sizeToFit];
    //building the scrollview

    [self.scrollView addSubview:imageView withAcceleration:(CGPoint){0.5f, 0.5f}];
    [self.scrollView addSubview:_textView];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _textView.frame.size.height +imageView.frame.size.height*.75)];
}

- (void)dismissBuildingView {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
