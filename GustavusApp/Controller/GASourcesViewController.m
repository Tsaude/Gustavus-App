//
//  GASourcesViewController.m
//  GustavusApp
//
//  Created by Tucker Saude on 1/28/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import "GASourcesViewController.h"

@interface GASourcesViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation GASourcesViewController{
    Building * _building;
}


-(void)setBuilding:(Building*) building{
    
    _building = building;
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setUpTextView];
}

-(void)setUpTextView{
    NSLog(@"%@S",_building.name);
    NSURL * URLpath = [[NSBundle mainBundle]URLForResource:[NSString stringWithFormat:@"%@S",_building.name] withExtension:@"rtf"];
    
    if (!URLpath) {
        URLpath = [[NSBundle mainBundle]URLForResource:@"sample" withExtension:@"rtf"];
    }
    
    NSMutableAttributedString*  mutableContent = [[NSMutableAttributedString alloc]initWithFileURL:URLpath
                                                                                           options:@{NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType}
                                                                                documentAttributes:nil
                                                                                             error:nil];
    [self.textView setAttributedText:mutableContent];
    [self.textView setScrollEnabled:YES];
    [self.textView setContentSize:[mutableContent size]];

    
}

-(BOOL)automaticallyAdjustsScrollViewInsets{
    return NO;
}
@end
