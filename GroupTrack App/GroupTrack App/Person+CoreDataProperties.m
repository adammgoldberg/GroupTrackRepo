//
//  Person+CoreDataProperties.m
//  GroupTrack App
//
//  Created by Adam Goldberg on 2015-11-17.
//  Copyright © 2015 Adam Goldberg. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

@dynamic firstName;
@dynamic lastName;
@dynamic numberOfPositives;
@dynamic numberOfNegatives;
@dynamic picture;
@dynamic events;
@dynamic leader;
@dynamic group;

@end
