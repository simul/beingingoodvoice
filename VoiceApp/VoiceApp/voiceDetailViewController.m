//
//  voiceDetailViewController.m
//  VoiceApp
//
//  Created by Flloyd Pauline Kennedy on 1/01/13.
//  Copyright (c) 2013 Flloyd Pauline Kennedy. All rights reserved.
//

#import "voiceDetailViewController.h"


@interface voiceDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation voiceDetailViewController

@synthesize webView;
@synthesize audioControl;

@synthesize detailItem;
@synthesize detailDescriptionLabel;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (detailItem != newDetailItem) {
        detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}
-(void)dealloc
{
    [audioControl stop];
}
- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
    //    self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    if([detailItem isKindOfClass:[NSString class]])
    {
        NSString *str=(NSString*)detailItem;
		audioControl.soundFile=str;
        NSString *htmlFile2= [[NSBundle mainBundle] pathForResource:str ofType:@"htm" inDirectory:@""];
        NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile2 encoding:NSUTF8StringEncoding error:nil];
        [webView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
    }
    [super viewDidLoad];
	
	playBtnBG = [UIImage imageNamed:@"play.png"];
	pauseBtnBG = [UIImage imageNamed:@"pause.png"];
	
	
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
