//
//  Building.h
//  GustavusApp
//
//  Created by Tucker Saude on 1/14/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Building : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* textFile;
@property (strong, nonatomic) NSString* pic;
@property (strong, nonatomic) NSString* title;

-(id)initWithName:(NSString*)name;

@end
