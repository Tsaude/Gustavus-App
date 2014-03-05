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

@implementation GABuildingViewController{
    UITextView * _textView;
    UINavigationBar * _navBar;
    UITableView * _tableView;
    UIImageView * _imageView;
    A3ParallaxScrollView * _scrollView;

}

-(void)viewWillAppear:(BOOL)animated{
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self buildNavBar];
    [self setUpNavBar];
    [self buildImageView];
    [self buildTextView];
    [self buildTableView];
    [self buildScrollView];

}

-(void)setUpNavBar{
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                target:self
                                                                                action:@selector(dismissBuildingView)];
    self.navigationItem.leftBarButtonItem = leftButton;
    [self.navigationItem setTitle:self.building.title];
    
}
-(void)buildScrollView{
    _scrollView = [[A3ParallaxScrollView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    [_scrollView addSubview:_imageView withAcceleration:(CGPoint){0.5f, 0.5f}];
    [_scrollView addSubview:_textView];
    [_scrollView addSubview:_tableView];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _textView.frame.size.height +_imageView.frame.size.height*.75f+_tableView.frame.size.height)];
    [self.view addSubview:_scrollView];
}
-(void)buildNavBar{
    _navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    [_navBar setBarTintColor:[UIColor darkTextColor]];
    _navBar.translucent = YES;
    UIBarButtonItem * back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismissBuildingView)];
    UINavigationItem * titleItem = [[UINavigationItem alloc] initWithTitle:self.building.title];
    [titleItem setLeftBarButtonItem:back];
    _navBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    _navBar.items = @[titleItem];
    [self.view addSubview:_navBar];
}
-(void)buildImageView{
    //getting image
    UIImage * image;
    
    NSLog(@"%@", self.building.pic);
    image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", self.building.name]];
    NSLog(@"%@", image);
    if(!image){
        
        
        image = [UIImage imageNamed:@"Chapel-Winter.png"];
        NSLog(@"%@", image);
        
        
    }
    
    _imageView = [[UIImageView alloc]initWithImage:image];
}
-(void)buildTextView{
    NSURL * URLpath = [[NSBundle mainBundle]URLForResource:self.building.name withExtension:@"rtf"];
    
    if (!URLpath) {
        URLpath = [[NSBundle mainBundle]URLForResource:@"sample" withExtension:@"rtf"];
    }
    
    NSMutableAttributedString*  mutableContent = [[NSMutableAttributedString alloc]initWithFileURL:URLpath
                                                                                           options:@{NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType}
                                                                                documentAttributes:nil
                                                                                             error:nil];
    
    
    
    for (int i = 0; i<[[mutableContent string] length]; i++) {
        NSRange  range = NSMakeRange(i, 1);
        //NSLog(@"%hhd",[[[content attributesAtIndex:i effectiveRange:&range] objectForKey:@"font-weight"] isEqualToString:@"bold"]);
        NSDictionary * attrib = [mutableContent attributesAtIndex:i effectiveRange:&range];
        UIFont * font = [attrib objectForKey:@"NSFont"];
        BOOL isBold = [[font fontName] hasSuffix:@"-Bold"];
        if (isBold) {
            [mutableContent setAttributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]} range:NSMakeRange(i, 1)];
        }
        else{
            [mutableContent setAttributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]} range:NSMakeRange(i, 1)];
        }
        
    }
    NSAttributedString * content = [[NSAttributedString alloc]initWithAttributedString:mutableContent];
    
    CGSize textSize = [content size];
    //CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //CGRect rect = [content boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    //CGSize textSize = rect.size;
    CGRect frameRect = CGRectMake(0, (_imageView.frame.size.height*.75), [[UIScreen mainScreen] bounds].size.width, textSize.height);
    _textView= [[UITextView alloc] initWithFrame:frameRect];
    [_textView setAttributedText:content];
    [_textView setDelegate:self];
    [_textView setScrollEnabled:NO];
    [_textView setUserInteractionEnabled:NO];
    [_textView sizeToFit];
    [_textView setFrame:CGRectMake(_textView.frame.origin.x, _textView.frame.origin.y, [UIScreen mainScreen].bounds.size.width, _textView.frame.size.height)];
    //
    //[_textView set]
}
-(void)buildTableView{
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

- (void)dismissBuildingView {
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



//Table View Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Sources";
    }
    /*
    if (indexPath.row == 1) {
        cell.textLabel.text = @"Sources";
    }
     */
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        /*NSLog(@"row 0 has been tapped!");
        
        
        
         */
        UITableViewCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
        [cell setHighlighted:NO];
        [_tableView reloadData];
        [self performSegueWithIdentifier:@"sources" sender:self];
        
    }
    
    if (indexPath.row == 1) {
        NSLog(@"row 1 has been tapped!");
        UITableViewCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
        [cell setHighlighted:NO];
        [_tableView reloadData];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    GABuildingViewController * buildingViewController = sender;
    NSLog(@"%@", buildingViewController.building.title);
    
    GASourcesViewController * sources = segue.destinationViewController;
    [sources.navigationItem setTitle:@"Sources"];
    [sources setBuilding:self.building];
    

}

@end
