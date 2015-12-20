//
//  C4QCatFactDetailViewController.m
//  unit-3-final-app-assessment
//
//  Created by Michael Kavouras on 12/18/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsDetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>


#define CAT_GIF_URL @"http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC"

@interface C4QCatFactsDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *factLabel;

@property (nonatomic) NSArray *imageDataArray;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation C4QCatFactsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.factLabel.text = self.fact;
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:CAT_GIF_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSDictionary *json = responseObject;
        NSArray *data = json[@"data"];
        self.imageDataArray = data;
        [self fetchImageDataAsync];
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@" Error: %@", error.localizedDescription);
    }];
    

}

-(void)reloadImageView
{
    int random =  arc4random_uniform(self.imageDataArray.count-1);
    
    NSDictionary *imagesDict = self.imageDataArray[random];
    NSDictionary *images = imagesDict[@"images"];
    NSDictionary *fixedWidthImageDict = images[@"fixed_width"];
    
    NSString *imageURLString = fixedWidthImageDict[@"url"];
    
    NSURL *url = [NSURL URLWithString:imageURLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    self.imageView.image = [UIImage imageWithData:data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchImageDataAsync
{
    int random =  arc4random_uniform(self.imageDataArray.count-1);
    
    NSDictionary *imagesDict = self.imageDataArray[random];
    NSDictionary *images = imagesDict[@"images"];
    NSDictionary *fixedWidthImageDict = images[@"fixed_width"];
    
    NSString *imageURLString = fixedWidthImageDict[@"url"];
    
    NSURL *url = [NSURL URLWithString:imageURLString];
    
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:url
                             options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                // progression tracking code
                            }
                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                               if (image && finished)
                               {
                                   self.imageView.image = image;
                               }
                               else
                               {
                                   NSLog(@"Error %@",error.localizedDescription);
                               }
                           }];

}



@end
