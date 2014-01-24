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
    UITableView * _tableView;
    UIImageView * _imageView;

}

-(void)viewWillAppear:(BOOL)animated{
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    [self buildNavBar];
    [self buildImageView];
    [self buildTextView];
    [self buildTableView];
    [self buildScrollView];

}
-(void)buildScrollView{
    [self.scrollView addSubview:_imageView withAcceleration:(CGPoint){0.5f, 0.5f}];
    [self.scrollView addSubview:_textView];
    [self.scrollView addSubview:_tableView];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _textView.frame.size.height +_imageView.frame.size.height*.75+_tableView.frame.size.height)];
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
    _textView= [[UITextView alloc] initWithFrame:CGRectMake(0, (_imageView.frame.size.height*.75), [[UIScreen mainScreen] bounds].size.width, textSize.height)];
    [_textView setAttributedText:content];
    [_textView setDelegate:self];
    [_textView setScrollEnabled:NO];
    [_textView setUserInteractionEnabled:NO];
    [_textView sizeToFit];
}
-(void)buildTableView{
    CGFloat tableViewHeight = 100;
    CGFloat tableViewy = (_imageView.frame.size.height*.75)+ _textView.frame.size.height;
    CGRect tableViewFrame = CGRectMake(0, tableViewy, [UIScreen mainScreen].bounds.size.width, tableViewHeight);
    
    
    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    
    _tableView.scrollEnabled = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.rowHeight = tableViewHeight/2;
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
}

- (void)dismissBuildingView {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
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
        cell.textLabel.text = @"Photos";
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = @"Sources";
    }
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSLog(@"row 0 has been tapped!");
        UITableViewCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
        [cell setHighlighted:NO];
        [_tableView reloadData];
        
    }
    
    if (indexPath.row == 1) {
        NSLog(@"row 1 has been tapped!");
        UITableViewCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
        [cell setHighlighted:NO];
        [_tableView reloadData];
        
    }
}

@end
