//
//  BirdSighting.h
//  BirdWatching
//
//  Created by Flloyd Pauline Kennedy on 30/12/12.
//  Copyright (c) 2012 Flloyd Pauline Kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BirdSighting : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic,strong) NSDate *date;
-(id)initWithName:(NSString*)name location:(NSString *)location date:(NSDate *)date;
@end
