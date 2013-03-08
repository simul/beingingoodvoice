//
//  beinginvoiceDataViewController.m
//  Being In Voice
//
//  Created by Flloyd Pauline Kennedy on 25/12/12.
//  Copyright (c) 2012 Flloyd Pauline Kennedy. All rights reserved.
//

#import "beinginvoiceDataViewController.h"

@interface beinginvoiceDataViewController ()

@end

@implementation beinginvoiceDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

@end
