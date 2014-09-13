//
//  NPViewController.m
//  NPKeyboardLayoutGuide
//
//  Created by Oleksii Kuchma on 09/13/2014.
//  Copyright (c) 2014 Oleksii Kuchma. All rights reserved.
//

#import "NPViewController.h"

#import "NPKeyboardLayoutGuide.h"

@interface NPViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bottomTextField;

@end

@implementation NPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[textField]-[keyboard]"
                                                                   options:kNilOptions
                                                                   metrics:nil
                                                                     views:@{@"textField" : self.bottomTextField, @"keyboard" : self.keyboardLayoutGuide}];
    
    [self.view addConstraints:constraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

@end
