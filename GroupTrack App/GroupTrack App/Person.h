//
//  Person.h
//  GroupTrack App
//
//  Created by Adam Goldberg on 2015-11-17.
//  Copyright © 2015 Adam Goldberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, Group, Leader;

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Person+CoreDataProperties.h"
