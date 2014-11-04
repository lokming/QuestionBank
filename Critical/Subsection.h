//
//  Subsection.h
//  Critical
//
//  Created by Lok on 04/11/2014.
//  Copyright (c) 2014 Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Section, Set;

@interface Subsection : NSManagedObject

@property (nonatomic, retain) NSString * subdivision;
@property (nonatomic, retain) Section *section2;
@property (nonatomic, retain) NSSet *set;
@end

@interface Subsection (CoreDataGeneratedAccessors)

- (void)addSetObject:(Set *)value;
- (void)removeSetObject:(Set *)value;
- (void)addSet:(NSSet *)values;
- (void)removeSet:(NSSet *)values;

@end
