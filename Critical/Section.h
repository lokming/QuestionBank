//
//  Section.h
//  Critical
//
//  Created by Lok on 04/11/2014.
//  Copyright (c) 2014 Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bank, Subsection;

@interface Section : NSManagedObject

@property (nonatomic, retain) NSString * division;
@property (nonatomic, retain) Bank *bank;
@property (nonatomic, retain) NSSet *thesubsection;
@end

@interface Section (CoreDataGeneratedAccessors)

- (void)addThesubsectionObject:(Subsection *)value;
- (void)removeThesubsectionObject:(Subsection *)value;
- (void)addThesubsection:(NSSet *)values;
- (void)removeThesubsection:(NSSet *)values;

@end
