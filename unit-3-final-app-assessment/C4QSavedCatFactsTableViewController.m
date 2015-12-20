//
//  C4QSavedCatFactsTableViewController.m
//  unit-3-final-app-assessment
//
//  Created by Mesfin Bekele Mekonnen on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QSavedCatFactsTableViewController.h"

@interface C4QSavedCatFactsTableViewController ()

@property (nonatomic) NSMutableArray *savedFactsArray;

@end

@implementation C4QSavedCatFactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.savedFactsArray= [[NSUserDefaults standardUserDefaults] objectForKey:@"SavedFacts"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.savedFactsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SavedFactsCellID" forIndexPath:indexPath];
    
    cell.textLabel.text = self.savedFactsArray[indexPath.row];
    return cell;
}

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
