//
//  Person+CoreDataProperties.h
//  GroupTrack App
//
//  Created by Adam Goldberg on 2015-11-17.
//  Copyright © 2015 Adam Goldberg. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSNumber *numberOfPositives;
@property (nullable, nonatomic, retain) NSNumber *numberOfNegatives;
@property (nullable, nonatomic, retain) NSData *picture;
@property (nullable, nonatomic, retain) NSSet<Event *> *events;
@property (nullable, nonatomic, retain) Leader *leader;
@property (nullable, nonatomic, retain) Group *group;

@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addEventsObject:(Event *)value;
- (void)removeEventsObject:(Event *)value;
- (void)addEvents:(NSSet<Event *> *)values;
- (void)removeEvents:(NSSet<Event *> *)values;

@end

NS_ASSUME_NONNULL_END
