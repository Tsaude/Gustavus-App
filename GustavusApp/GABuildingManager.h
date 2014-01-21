//
//  GABuildingManager.h
//  GustavusApp
//
//  Created by Tucker Saude on 1/17/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GABuildingManager : NSObject

@property (strong, nonatomic) NSDictionary * buildingInfo;

+ (id)sharedManager;

@end
