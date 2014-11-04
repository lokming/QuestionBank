//
//  Set.h
//  Critical
//
//  Created by Lok on 04/11/2014.
//  Copyright (c) 2014 Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Question, Subsection;

@interface Set : NSManagedObject

@property (nonatomic, retain) NSString * group;
@property (nonatomic, retain) NSSet *question;
@property (nonatomic, retain) Subsection *subsections;
@end

@interface Set (CoreDataGeneratedAccessors)

- (void)addQuestionObject:(Question *)value;
- (void)removeQuestionObject:(Question *)value;
- (void)addQuestion:(NSSet *)values;
- (void)removeQuestion:(NSSet *)values;

@end
