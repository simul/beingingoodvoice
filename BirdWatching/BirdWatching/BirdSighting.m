//
//  BirdSighting.m
//  BirdWatching
//
//  Created by Flloyd Pauline Kennedy on 30/12/12.
//  Copyright (c) 2012 Flloyd Pauline Kennedy. All rights reserved.
//

#import "BirdSighting.h"

@implementation BirdSighting
-(id)initWithName:(NSString *)name location:(NSString *)location date:(NSDate *)date
{
    self = [super init];
    if(self)
    {
        _name=name;
        _location=location;
        _date=date;
        return self;
    }
    return nil;
}
@end
