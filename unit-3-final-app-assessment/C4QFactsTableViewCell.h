//
//  C4QFactsTableViewCell.h
//  unit-3-final-app-assessment
//
//  Created by Mesfin Bekele Mekonnen on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol C4QFactsTableViewCellDelegate <NSObject>

-(void)userAddedFactAtIndex:(NSInteger )index;

@end

@interface C4QFactsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *plusButton;

@property (weak, nonatomic) IBOutlet UILabel *factLabel;
@property (nonatomic) NSInteger index;

@property (nonatomic, weak) id<C4QFactsTableViewCellDelegate> delegate;

@end
