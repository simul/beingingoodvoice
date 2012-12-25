//
//  beinginvoiceModelController.h
//  Being In Voice
//
//  Created by Flloyd Pauline Kennedy on 25/12/12.
//  Copyright (c) 2012 Flloyd Pauline Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class beinginvoiceDataViewController;

@interface beinginvoiceModelController : NSObject <UIPageViewControllerDataSource>

- (beinginvoiceDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(beinginvoiceDataViewController *)viewController;

@end
