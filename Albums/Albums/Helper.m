//
//  Helper.m
//  Albums
//
//  Created by Uday Kiran Ailapaka on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import "Helper.h"
#import "ModelCoordinator.h"
#import "AppDelegate.h"

@implementation Helper
{
    ModelCoordinator *modelCoordinator;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static Helper *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init{
    if (self = [super init]) {
        modelCoordinator = [[ModelCoordinator alloc] init];
    }
    return self;
}

- (void)fetchAlbumsFromDB:(void (^)(NSArray *))completionBlock {
    completionBlock([modelCoordinator fetchAlbums]);
}

- (void)fetchAlbumsFromService:(void (^)(NSArray *))completionBlock {
    
    NSURL *albumURL = [[NSURL alloc] initWithString:@"http://jsonplaceholder.typicode.com/albums"];
    
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    NSURLSessionDataTask *dataTask=[session dataTaskWithURL:albumURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        NSArray *albums = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if (jsonError) {
            NSLog(@"error is %@", [jsonError localizedDescription]);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock([modelCoordinator fetchAlbums]);
            });
            // Handle Error and return
        } else {
            NSURL *usersURL=[NSURL URLWithString:@"http://jsonplaceholder.typicode.com/users"];
            NSURLSessionDataTask *dataTask=[session dataTaskWithURL:usersURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSError *jsonError = nil;
                NSArray *users=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                if (jsonError) {
                    NSLog(@"error is %@", [jsonError localizedDescription]);
                    // Handle Error and return
                } else {
                    
                    [modelCoordinator saveToDBUsers:(NSArray *)users andAlbums:(NSArray *)albums];
                }

                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock([modelCoordinator fetchAlbums]);
                });
                
            }];
            [dataTask resume];
            
            
        }
        
    }];
    [dataTask resume];

}


@end
