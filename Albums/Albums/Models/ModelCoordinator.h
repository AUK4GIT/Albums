//
//  ModelCoordinator.h
//  Albums
//
//  Created by Uday Kiran Ailapaka on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"


@interface ModelCoordinator : NSObject

- (NSArray *)fetchAlbums;
- (void)saveToDBUsers:(NSArray *)users andAlbums:(NSArray *)albums;
- (void)saveToDBPhotos:(NSArray *)users forAlbum:(id)album;
- (NSArray *)fetchPhotosForAlbumId:(NSString *)albumId;
@end
