//
//  birdsMasterViewController.h
//  BirdWatching
//
//  Created by Flloyd Pauline Kennedy on 29/12/12.
//  Copyright (c) 2012 Flloyd Pauline Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BirdsDetailViewController;
@class BirdSightingDataController;

@interface BirdsMasterViewController : UITableViewController

@property (strong, nonatomic) BirdSightingDataController *dataController;

@end
