//
//  C4QCatsTableViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsTableViewController.h"
#import "C4QFactsTableViewCell.h"
#import "C4QCatFactsDetailViewController.h"
#import "C4QSavedCatFactsTableViewController.h"

#import <AFNetworking/AFNetworking.h>

#define CAT_API_URL @"http://catfacts-api.appspot.com/api/facts?number=100"

@interface C4QCatFactsTableViewController ()<C4QFactsTableViewCellDelegate>

@property (nonatomic) NSMutableArray *facts;

@property (nonatomic) NSMutableArray *savedFacts;

@property (nonatomic) NSMutableArray *catFacts;

@property (nonatomic) NSString *fact;

@end

@implementation C4QCatFactsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.savedFacts = [NSMutableArray new];
    
    
    UINib *nib = [UINib nibWithNibName:@"C4QFactsTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CatFactIdentifier"];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/javascript"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 160.0;
    
    [manager GET:CAT_API_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress)
     {
         
     }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         self.facts = [NSMutableArray new];
         NSDictionary *json = responseObject;
         NSArray *facts = json[@"facts"];
         self.facts = [NSMutableArray arrayWithArray:facts];
         
         [self.tableView reloadData];
         
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error %@", error.localizedDescription);
     }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.facts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    C4QFactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CatFactIdentifier" forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.index = indexPath.row;
    
    cell.factLabel.text = self.facts[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    C4QCatFactsDetailViewController *c4qdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"C4QCatFactsDetailVCID"];
    
    c4qdvc.fact = self.facts[indexPath.row];
    
    [self.navigationController pushViewController:c4qdvc animated:YES];
    
}

#pragma mark - C4QTableViewCellDelegate

-(void)userAddedFactAtIndex:(NSInteger)index
{
    if(!self.catFacts)
    {
        self.catFacts = [NSMutableArray new];
    }
    
    
    NSString *factToBeSaved = self.facts[index];
    
    
    [self.catFacts addObject:factToBeSaved];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:factToBeSaved forKey:factToBeSaved];
    //new Fact
    self.fact = factToBeSaved;
    
    [self.savedFacts addObject:factToBeSaved];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Saved" message:@"New Cat Fact Saved" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)savedButtonTapped:(UIBarButtonItem *)sender
{
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"savedFactsNavControllerID"];
    
    C4QSavedCatFactsTableViewController *c4qscftvc = (C4QSavedCatFactsTableViewController *)navController.topViewController;
    
    c4qscftvc.savedFacts = [NSMutableArray arrayWithArray:self.facts];
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"SavedFacts"];
    
    if(!array)
    {
        [[NSUserDefaults standardUserDefaults] setObject:self.savedFacts forKey:@"SavedFacts"];
    }
    else
    {
        if([self isNewFact])
        {
            NSMutableArray *oldSavedArray = [NSMutableArray arrayWithArray:array];
            [oldSavedArray addObject:self.fact];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SavedFacts"];

            [[NSUserDefaults standardUserDefaults] setObject:oldSavedArray forKey:@"SavedFacts"];
        }
    }
    
    [self.navigationController presentViewController:navController animated:YES completion:nil];
    
}

-(BOOL)isNewFact
{
    BOOL newFact = NO;
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"SavedFacts"];
    for(int i = 0; i < self.catFacts.count; i++)
    {
        NSString *fact = self.catFacts[i];
        if(![array containsObject:fact])
        {
            newFact = YES;
            break;
        }
    }
    return newFact;
}



@end
