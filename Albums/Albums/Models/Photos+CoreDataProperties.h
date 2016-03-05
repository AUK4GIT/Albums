//
//  Photos+CoreDataProperties.h
//  Albums
//
//  Created by Uday Kiran Ailapaka on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photos.h"

NS_ASSUME_NONNULL_BEGIN

@interface Photos (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *photoId;
@property (nullable, nonatomic, retain) NSNumber *userId;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *photoURL;
@property (nullable, nonatomic, retain) NSString *photoThumbnailURL;
@property (nullable, nonatomic, retain) Albums *album;

@end

NS_ASSUME_NONNULL_END
