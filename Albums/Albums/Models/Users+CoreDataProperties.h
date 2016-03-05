//
//  Users+CoreDataProperties.h
//  Albums
//
//  Created by Uday Kiran Ailapaka on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Users.h"

NS_ASSUME_NONNULL_BEGIN

@interface Users (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *userId;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSString *userEmail;
@property (nullable, nonatomic, retain) NSString *userAddress;
@property (nullable, nonatomic, retain) NSString *userPhone;
@property (nullable, nonatomic, retain) NSString *userWebSite;
@property (nullable, nonatomic, retain) NSString *userCompany;
@property (nullable, nonatomic, retain) Albums *album;

@end

NS_ASSUME_NONNULL_END
