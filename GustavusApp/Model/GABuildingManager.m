//
//  GABuildingManager.m
//  GustavusApp
//
//  Created by Tucker Saude on 1/17/14.
//  Copyright (c) 2014 Tucker Saude. All rights reserved.
//

#import "GABuildingManager.h"

@implementation GABuildingManager


+ (id)sharedManager {
    static GABuildingManager *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}


- (id)init
{
    self = [super init];
    if (self) {
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask,YES)
                              objectAtIndex:0];
        
        plistPath = [rootPath stringByAppendingPathComponent:@"buildings.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            plistPath = [[NSBundle mainBundle] pathForResource:@"buildings" ofType:@"plist"];
        }
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        if (!temp) {
            NSLog(@"Error reading plist: %@", errorDesc);
        }
        self.buildingInfo = temp;
        //NSLog(@"%@",self.buildingInfo);
    }
    return self;
}

@end
