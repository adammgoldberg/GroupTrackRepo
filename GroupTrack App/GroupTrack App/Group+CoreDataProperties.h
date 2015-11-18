//
//  Group+CoreDataProperties.h
//  GroupTrack App
//
//  Created by Adam Goldberg on 2015-11-17.
//  Copyright © 2015 Adam Goldberg. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Group.h"

NS_ASSUME_NONNULL_BEGIN

@interface Group (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Person *> *persons;
@property (nullable, nonatomic, retain) NSSet<Event *> *events;
@property (nullable, nonatomic, retain) Leader *leader;

@end

@interface Group (CoreDataGeneratedAccessors)

- (void)addPersonsObject:(Person *)value;
- (void)removePersonsObject:(Person *)value;
- (void)addPersons:(NSSet<Person *> *)values;
- (void)removePersons:(NSSet<Person *> *)values;

- (void)addEventsObject:(Event *)value;
- (void)removeEventsObject:(Event *)value;
- (void)addEvents:(NSSet<Event *> *)values;
- (void)removeEvents:(NSSet<Event *> *)values;

@end

NS_ASSUME_NONNULL_END
