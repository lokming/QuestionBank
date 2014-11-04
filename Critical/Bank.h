//
//  Bank.h
//  Critical
//
//  Created by Lok on 04/11/2014.
//  Copyright (c) 2014 Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Section;

@interface Bank : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSSet *thesection;
@end

@interface Bank (CoreDataGeneratedAccessors)

- (void)addThesectionObject:(Section *)value;
- (void)removeThesectionObject:(Section *)value;
- (void)addThesection:(NSSet *)values;
- (void)removeThesection:(NSSet *)values;

@end
