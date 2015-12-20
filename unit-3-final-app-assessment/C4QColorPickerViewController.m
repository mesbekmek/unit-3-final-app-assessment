//
//  C4QColorPickerViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QColorPickerViewController.h"

@interface C4QColorPickerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;

@end

@implementation C4QColorPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blueButton.backgroundColor = [UIColor blueColor];
    self.greenButton.backgroundColor = [UIColor greenColor];
    self.redButton.backgroundColor = [UIColor redColor];
}
- (IBAction)greenButtonTapped:(UIButton *)sender
{
    [self.delegate userDidPickColor:sender.backgroundColor];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)blueButtonTapped:(UIButton *)sender
{
    [self.delegate userDidPickColor:sender.backgroundColor];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)redButtonTapped:(UIButton *)sender
{
    [self.delegate userDidPickColor:sender.backgroundColor];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
