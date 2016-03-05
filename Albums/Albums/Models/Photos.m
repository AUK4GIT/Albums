//
//  Photos.m
//  Albums
//
//  Created by Uday Kiran Ailapaka on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import "Photos.h"
#import "Albums.h"

@implementation Photos

// Insert code here to add functionality to your managed object subclass

- (void)saveData:(NSDictionary *)photoDict {

    if ([[photoDict objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
        NSNumber *albId = [photoDict objectForKey:@"id"];
        self.photoId = albId;
    } else {
        NSString *albId = [photoDict objectForKey:@"id"];
        self.photoId = [NSNumber numberWithInteger:albId.integerValue];
    }
    
    if ([[photoDict objectForKey:@"albumId"] isKindOfClass:[NSNumber class]]) {
        NSNumber *albId = [photoDict objectForKey:@"albumId"];
        self.albumId = albId;
    } else {
        NSString *albId = [photoDict objectForKey:@"albumId"];
        self.albumId = [NSNumber numberWithInteger:albId.integerValue];
    }
    
    self.title = [photoDict objectForKey:@"title"];
    self.photoURL = [photoDict objectForKey:@"url"];
    self.photoThumbnailURL = [photoDict objectForKey:@"thumbnailUrl"];
}

@end
