//
//  Albums.m
//  Albums
//
//  Created by Uday Kiran Ailapaka on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import "Albums.h"
#import "Users.h"

@implementation Albums

// Insert code here to add functionality to your managed object subclass

- (void)saveData:(NSDictionary *)albumDict userDict:(NSDictionary *)userDict{
    if ([[albumDict objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
        NSNumber *albId = [albumDict objectForKey:@"id"];
        self.albumId = albId;
    } else {
        NSString *albId = [albumDict objectForKey:@"id"];
        self.albumId = [NSNumber numberWithInteger:albId.integerValue];
    }
    
    if ([[albumDict objectForKey:@"userId"] isKindOfClass:[NSNumber class]]) {
        NSNumber *usrId = [albumDict objectForKey:@"userId"];
        self.userId = usrId;
    } else {
        NSString *usrId = [albumDict objectForKey:@"userId"];
        self.userId = [NSNumber numberWithInteger:usrId.integerValue];
    }
    self.albumTitle = [albumDict objectForKey:@"title"];
    
    if ([userDict allKeys].count > 0) {
        self.userName = [userDict objectForKey:@"username"];
        
        NSEntityDescription *entityPerson = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
        Users *user = (Users *)[[NSManagedObject alloc] initWithEntity:entityPerson insertIntoManagedObjectContext:self.managedObjectContext];
        
        if ([[albumDict objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            NSNumber *albId = [albumDict objectForKey:@"id"];
            user.userId = albId;
        } else {
            NSString *albId = [albumDict objectForKey:@"id"];
            user.userId = [NSNumber numberWithInteger:albId.integerValue];
        }
        user.userName = [userDict objectForKey:@"username"];
        user.name = [userDict objectForKey:@"name"];
        user.userEmail = [userDict objectForKey:@"email"];
        user.userPhone = [userDict objectForKey:@"phone"];
        user.userWebSite = [userDict objectForKey:@"website"];
        
//        user.userAddress = [userDict objectForKey:@"email"];
//        user.userCompany = [userDict objectForKey:@"email"];
        
        [self setValue:user forKey:@"user"];

    }
}


@end
