//
//  ViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 11/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QViewController.h"

@interface C4QViewController ()
@property (weak, nonatomic) IBOutlet UIButton *onwardButton;

@property (weak, nonatomic) IBOutlet UIButton *selectAColorButton;
@end

@implementation C4QViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.onwardButton setHidden:YES];
}
- (IBAction)selectAColorButtonTapped:(UIButton *)sender
{
    C4QColorPickerViewController *cpvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ColorPickerViewID"];
    
    cpvc.delegate = self;
    
    [self.navigationController pushViewController:cpvc animated:YES];
}

- (IBAction)onwardButtonTapped:(UIButton *)sender
{
    
}

-(void)userDidPickColor:(UIColor *)color
{
    [self.view setBackgroundColor:color];
}

@end
