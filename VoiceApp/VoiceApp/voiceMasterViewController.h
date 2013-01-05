//
//  voiceMasterViewController.h
//  VoiceApp
//
//  Created by Flloyd Pauline Kennedy on 1/01/13.
//  Copyright (c) 2013 Flloyd Pauline Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>


extern UIColor* convertWebColour(uint i);
@class voiceDetailViewController;

@interface voiceMasterViewController : UITableViewController
@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) voiceDetailViewController *detailViewController;

@end
