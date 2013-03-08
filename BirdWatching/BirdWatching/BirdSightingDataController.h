//
//  BirdSightingDataController.h
//  BirdWatching
//
//  Created by Flloyd Pauline Kennedy on 30/12/12.
//  Copyright (c) 2012 Flloyd Pauline Kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BirdSighting;

@interface BirdSightingDataController : NSObject

@property (nonatomic, copy) NSMutableArray *masterBirdSightingList;

-(NSUInteger)countOfList;

-(BirdSighting *)objectInListAtIndex:(NSUInteger)theIndex;

-(void)addBirdSightingWithSighting:(BirdSighting *)sighting;

@end
