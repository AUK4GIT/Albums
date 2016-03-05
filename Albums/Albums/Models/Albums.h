//
//  Albums.h
//  Albums
//
//  Created by Uday Kiran Ailapaka on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Albums : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (void)saveData:(NSDictionary *)albumDict userDict:(NSDictionary *)userDict;
@end

NS_ASSUME_NONNULL_END

#import "Albums+CoreDataProperties.h"
