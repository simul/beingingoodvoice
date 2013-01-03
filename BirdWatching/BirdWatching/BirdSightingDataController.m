//
//  BirdSightingDataController.m
//  BirdWatching
//
//  Created by Flloyd Pauline Kennedy on 30/12/12.
//  Copyright (c) 2012 Flloyd Pauline Kennedy. All rights reserved.
//

#import "BirdSightingDataController.h"
#import "BirdSighting.h"

@interface BirdSightingDataController()
- (void)initializeDefaultDataList;
@end

@implementation BirdSightingDataController

- (void)initializeDefaultDataList
{
    NSMutableArray *sightingList=[[NSMutableArray alloc] init];
    self.masterBirdSightingList = sightingList;
    BirdSighting *sighting;
    NSDate *today = [NSDate date];
    sighting = [[BirdSighting alloc] initWithName:@"Pigeon" location:@"Everywhere" date:today];
    [self addBirdSightingWithSighting:sighting];
}

- (void)setMasterBirdSightingList:(NSMutableArray *)newList
{
    if(_masterBirdSightingList != newList)
    {
        _masterBirdSightingList=[newList mutableCopy];
    }
}

- (id)init
{
    if(self=[super init])
    {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

- (NSUInteger) countOfList
{
    return [self.masterBirdSightingList count];
}

- (BirdSighting*)objectInListAtIndex:(NSUInteger)theIndex
{
    return [self.masterBirdSightingList objectAtIndex:theIndex];
}

- (void)addBirdSightingWithSighting:(BirdSighting *)sighting
{
    [self.masterBirdSightingList addObject:sighting];
}
@end
