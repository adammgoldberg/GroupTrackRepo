//
//  Leader+CoreDataProperties.h
//  GroupTrack App
//
//  Created by Adam Goldberg on 2015-11-17.
//  Copyright © 2015 Adam Goldberg. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Leader.h"

NS_ASSUME_NONNULL_BEGIN

@interface Leader (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<Group *> *groups;
@property (nullable, nonatomic, retain) NSSet<Person *> *persons;

@end

@interface Leader (CoreDataGeneratedAccessors)

- (void)addGroupsObject:(Group *)value;
- (void)removeGroupsObject:(Group *)value;
- (void)addGroups:(NSSet<Group *> *)values;
- (void)removeGroups:(NSSet<Group *> *)values;

- (void)addPersonsObject:(Person *)value;
- (void)removePersonsObject:(Person *)value;
- (void)addPersons:(NSSet<Person *> *)values;
- (void)removePersons:(NSSet<Person *> *)values;

@end

NS_ASSUME_NONNULL_END
