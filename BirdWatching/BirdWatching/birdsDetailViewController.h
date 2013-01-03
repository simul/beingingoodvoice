//
//  birdsDetailViewController.h
//  BirdWatching
//
//  Created by Flloyd Pauline Kennedy on 29/12/12.
//  Copyright (c) 2012 Flloyd Pauline Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BirdsDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
