//
//  ModelCoordinator.m
//  Albums
//
//  Created by Uday Kiran Ailapaka on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import "ModelCoordinator.h"
#import "Albums.h"
#import "Users.h"
#import "Photos.h"

@implementation ModelCoordinator
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *managedContext;
}
- (id)init{
    if (self = [super init]) {
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        managedContext = appDelegate.managedObjectContext;
    }
    return self;
}

- (NSArray *)fetchAlbums {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Albums"];
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"albumId" ascending:true];
    request.sortDescriptors = @[sortDesc];
    NSError *error = nil;
    NSArray *results = [managedContext executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    return results == nil ? @[] : results;
}

- (NSArray *)fetchPhotosForAlbumId:(NSString *)albumId {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photos"];
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"photoId" ascending:true];
    NSPredicate *predic = [NSPredicate predicateWithFormat:@"albumId == %@",albumId];
    request.sortDescriptors = @[sortDesc];
    request.predicate = predic;
    NSError *error = nil;
    NSArray *results = [managedContext executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    return results == nil ? @[] : results;
}

- (void)saveToDBUsers:(NSArray *)users andAlbums:(NSArray *)albums{
    [self deleteData:@"Albums"];
    [self deleteData:@"Users"];
    [self deleteData:@"Photos"];
    [self saveContext];
    for (NSDictionary *albumDict in albums) {
        NSEntityDescription *entityPerson = [NSEntityDescription entityForName:@"Albums" inManagedObjectContext:managedContext];
        Albums *album = (Albums *)[[NSManagedObject alloc] initWithEntity:entityPerson insertIntoManagedObjectContext:managedContext];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@",[albumDict objectForKey:@"userId"]];
        NSArray *filteredArry=[[users filteredArrayUsingPredicate:predicate] copy];
        if (filteredArry.count > 0) {
            [album saveData:albumDict userDict:filteredArry[0]];
        } else {
            [album saveData:albumDict userDict:@{}];
        }
    }
    [self saveContext];
}

- (void)saveToDBPhotos:(NSArray *)photos forAlbum:(id)album{
    NSManagedObject *albumObj = (NSManagedObject *)album;
    NSMutableSet *mSet = [NSMutableSet set];
    for (NSDictionary *photoDict in photos) {
        NSEntityDescription *entityPerson = [NSEntityDescription entityForName:@"Photos" inManagedObjectContext:managedContext];
        Photos *photo = (Photos *)[[NSManagedObject alloc] initWithEntity:entityPerson insertIntoManagedObjectContext:managedContext];
        [photo saveData:(NSDictionary *)photoDict];
        [mSet addObject:photo];
    }
    [albumObj setValue:[NSSet setWithSet:mSet] forKey:@"photos"];
    [self saveContext];
}



- (void)deleteData:(NSString *)entity {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entity];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *deleteError = nil;
    [appDelegate.persistentStoreCoordinator executeRequest:delete withContext:managedContext error:&deleteError];
    if(deleteError){
        NSAssert(NO, @"Error Deleting Entity: %@\n%@", [deleteError localizedDescription], [deleteError userInfo]);
    }

}
- (void)saveContext{
    NSError *error = nil;
    if ([managedContext save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

@end
