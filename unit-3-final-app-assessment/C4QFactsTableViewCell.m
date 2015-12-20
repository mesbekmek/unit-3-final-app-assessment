//
//  C4QFactsTableViewCell.m
//  unit-3-final-app-assessment
//
//  Created by Mesfin Bekele Mekonnen on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QFactsTableViewCell.h"

@implementation C4QFactsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)plusButtonTapped:(UIButton *)sender
{
    
    [self.delegate userAddedFactAtIndex:self.index];
}

@end
