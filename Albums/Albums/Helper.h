//
//  Helper.h
//  Albums
//
//  Created by Uday Kiran Ailapaka on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject
+ (instancetype)sharedInstance;

- (void)fetchAlbumsFromDB: (void (^)(NSArray *))completionBlock;
- (void)fetchAlbumsFromService:(void (^)(NSArray *))completionBlock;
- (void)fetchPhotosFromServiceForAlbumId:(NSString *)albumId forAlbum:(id)album completionHandler:(void (^)(NSArray *))completionBlock;
- (void)fetchImageWithURLString:(NSString *)urlString completionHandler:(void (^)(UIImage *))completionBlock;

@end
