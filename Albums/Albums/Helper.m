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

- (void)fetchPhotosFromDBForAlbumId:(NSString *)albumId withCompletionHandler:(void (^)(NSArray *))completionBlock {
    completionBlock([modelCoordinator fetchAlbums]);
}

- (void)fetchAlbumsFromService:(void (^)(NSArray *))completionBlock {
    
    NSURL *albumURL = [[NSURL alloc] initWithString:@"http://jsonplaceholder.typicode.com/albums"];
    
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    NSURLSessionDataTask *dataTask=[session dataTaskWithURL:albumURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil ) {
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
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock([modelCoordinator fetchAlbums]);
            });
        }
        
    }];
    [dataTask resume];

}

- (void)fetchPhotosFromServiceForAlbumId:(NSString *)albumId forAlbum:(id)album completionHandler:(void (^)(NSArray *))completionBlock {
    
    NSURL *albumURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://jsonplaceholder.typicode.com/photos/?albumId=%@",albumId]];
    NSLog(@"albumURL:  %@",albumURL);
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    NSURLSessionDataTask *dataTask=[session dataTaskWithURL:albumURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            NSError *jsonError = nil;
            NSArray *photos = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (jsonError) {
                NSLog(@"error is %@", [jsonError localizedDescription]);
                // Handle Error and return
            } else {
                [modelCoordinator saveToDBPhotos:(NSArray *)photos forAlbum:(id)album];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock([modelCoordinator fetchPhotosForAlbumId:albumId]);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock([modelCoordinator fetchPhotosForAlbumId:albumId]);
            });
        }

        
    }];
    [dataTask resume];
    
}

- (void)fetchImageWithURLString:(NSString *)urlString completionHandler:( void (^)(UIImage *))completionBlock {
    NSURL *photoURL = [[NSURL alloc] initWithString:urlString];
    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]
                                                   downloadTaskWithURL:photoURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                       // 3
                                                       UIImage *downloadedImage = [UIImage imageWithData:
                                                                                   [NSData dataWithContentsOfURL:location]];
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           completionBlock(downloadedImage);
                                                       });
                                                   }];
    
    [downloadPhotoTask resume];
}

@end
