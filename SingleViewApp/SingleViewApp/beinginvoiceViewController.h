//
//  beinginvoiceViewController.h
//  SingleViewApp
//
//  Created by Flloyd Pauline Kennedy on 25/12/12.
//  Copyright (c) 2012 Flloyd Pauline Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface beinginvoiceViewController :  UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)changeGreeting:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (copy, nonatomic) NSString *userName;
@end
