//
//  Building.m
//  GustavusApp
//
//  Created by Tucker Saude on 1/14/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import "Building.h"
#import "GABuildingManager.h"

@implementation Building

-(id)initWithName:(NSString*)name{
    self = [super init];
    if(self){
        self.name = name;
        self.textFile = [NSString stringWithFormat:@"%@.txt", self.name];
        self.pic = [NSString stringWithFormat:@"%@.jpg", self.name];
        self.title = [[GABuildingManager sharedManager] buildingInfo][self.name][@"name"];
    }
    return self;
}

@end
