//
//  Event+CoreDataProperties.h
//  GroupTrack App
//
//  Created by Adam Goldberg on 2015-11-17.
//  Copyright © 2015 Adam Goldberg. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *details;
@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) Person *person;
@property (nullable, nonatomic, retain) Group *group;

@end

NS_ASSUME_NONNULL_END
