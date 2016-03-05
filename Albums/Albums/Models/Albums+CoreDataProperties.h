//
//  Albums+CoreDataProperties.h
//  Albums
//
//  Created by Uday Kiran Ailapaka on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Albums.h"

NS_ASSUME_NONNULL_BEGIN

@interface Albums (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *albumId;
@property (nullable, nonatomic, retain) NSString *albumTitle;
@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSNumber *userId;
@property (nullable, nonatomic, retain) NSManagedObject *user;
@property (nullable, nonatomic, retain) NSManagedObject *photos;

@end

NS_ASSUME_NONNULL_END
