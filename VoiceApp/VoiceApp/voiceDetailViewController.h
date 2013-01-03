//
//  voiceDetailViewController.h
//  VoiceApp
//
//  Created by Flloyd Pauline Kennedy on 1/01/13.
//  Copyright (c) 2013 Flloyd Pauline Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface voiceDetailViewController : UIViewController <UISplitViewControllerDelegate>  {
    IBOutlet UIWebView *webView;
}

@property (nonatomic, retain) UIWebView *webView;

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
