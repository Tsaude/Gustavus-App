//
//  GABuildingViewController.m
//  GustavusApp
//
//  Created by Tucker Saude on 1/13/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//



#import "GABuildingViewController.h"


@interface GABuildingViewController ()


@end

@implementation GABuildingViewController {
    UITextView * _textView;
    UINavigationBar * _navBar;
    UITableView * _tableView;
    UIImageView * _imageView;
    A3ParallaxScrollView * _scrollView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavBar];
    [self buildImageView];
    [self buildTextView];
    [self buildTableView];
    [self buildScrollView];

}

- (void)setUpNavBar {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                target:self
                                                                                action:@selector(dismissBuildingView)];
    self.navigationItem.leftBarButtonItem = leftButton;
    [self.navigationItem setTitle:self.building.title];
    
}

- (void)buildImageView {
    //getting image
    UIImage * image;
    
    image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", self.building.name]];
    if(!image){
        image = [UIImage imageNamed:@"Chapel-Winter.png"];
    }
    
    _imageView = [[UIImageView alloc]initWithImage:image];
    CGRect frame = _imageView.frame;
    if (frame.size.width < [UIScreen mainScreen].bounds.size.width) {
        CGFloat diff = [UIScreen mainScreen].bounds.size.width - frame.size.width;
        frame.size.width += diff;
        frame.size.height += diff;
    }
    _imageView.frame = frame;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)buildTextView {
    NSURL * URLpath = [[NSBundle mainBundle]URLForResource:self.building.name withExtension:@"rtf"];
    
    if (!URLpath) {
        URLpath = [[NSBundle mainBundle]URLForResource:@"sample" withExtension:@"rtf"];
    }
    
    NSMutableAttributedString*  mutableContent = [[NSMutableAttributedString alloc] initWithFileURL:URLpath
                                                                                            options:@{NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType}
                                                                                documentAttributes:nil
                                                                                             error:nil];
    for (int i = 0; i<[[mutableContent string] length]; i++) {
        NSRange  range = NSMakeRange(i, 1);
        NSDictionary * attrib = [mutableContent attributesAtIndex:i effectiveRange:&range];
        UIFont * font = [attrib objectForKey:@"NSFont"];
        BOOL isBold = [[font fontName] hasSuffix:@"-Bold"];
        if (isBold) {
            [mutableContent setAttributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]} range:NSMakeRange(i, 1)];
        }
        else {
            [mutableContent setAttributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]} range:NSMakeRange(i, 1)];
        }
        
    }
    NSAttributedString * content = [[NSAttributedString alloc]initWithAttributedString:mutableContent];
    CGSize textSize = [content size];
    CGRect frameRect = CGRectMake(0, (_imageView.frame.size.height*.75), [[UIScreen mainScreen] bounds].size.width, textSize.height);
    _textView= [[UITextView alloc] initWithFrame:frameRect];
    [_textView setAttributedText:content];
    [_textView setDelegate:self];
    [_textView setScrollEnabled:NO];
    [_textView setUserInteractionEnabled:NO];
    [_textView sizeToFit];
    [_textView setFrame:CGRectMake(_textView.frame.origin.x, _textView.frame.origin.y, [UIScreen mainScreen].bounds.size.width, _textView.frame.size.height)];
}


- (void)buildTableView {
    CGFloat tableViewHeight = 50;
    CGFloat tableViewy = (_imageView.frame.size.height*.75)+ _textView.frame.size.height;
    CGRect tableViewFrame = CGRectMake(0, tableViewy, [UIScreen mainScreen].bounds.size.width, tableViewHeight);
    
    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    _tableView.scrollEnabled = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.rowHeight = tableViewHeight;
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}


- (void)buildScrollView {
    _scrollView = [[A3ParallaxScrollView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    [_scrollView addSubview:_imageView withAcceleration:(CGPoint){0.5f, 0.5f}];
    [_scrollView addSubview:_textView];
    [_scrollView addSubview:_tableView];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _textView.frame.size.height +_imageView.frame.size.height*.75f+_tableView.frame.size.height)];
    [self.view addSubview:_scrollView];
}

- (void)dismissBuildingView {
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



//Table View Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Sources";
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
        [cell setHighlighted:NO];
        [_tableView reloadData];
        [self performSegueWithIdentifier:@"sources" sender:self];
    }
    
    if (indexPath.row == 1) {
        UITableViewCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
        [cell setHighlighted:NO];
        [_tableView reloadData];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GASourcesViewController * sources = segue.destinationViewController;
    [sources.navigationItem setTitle:@"Sources"];
    [sources setBuilding:self.building];
}

@end
