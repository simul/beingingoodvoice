//
//  beinginvoiceViewController.m
//  SingleViewApp
//
//  Created by Flloyd Pauline Kennedy on 25/12/12.
//  Copyright (c) 2012 Flloyd Pauline Kennedy. All rights reserved.
//

#import "beinginvoiceViewController.h"

@interface beinginvoiceViewController ()

@end

@implementation beinginvoiceViewController
@synthesize userName = _userName;

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

- (IBAction)changeGreeting:(id)sender {
    self.userName = self.textField.text;
    
    NSString *nameString = self.userName;
    if ([nameString length] == 0) {
        nameString = @"World";
    }
    NSString *greeting = [[NSString alloc] initWithFormat:@"Hello, %@!", nameString];
    self.label.text = greeting;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if(theTextField==self.textField)
    {
        [theTextField resignFirstResponder];
    }
    return YES;
}

@end
