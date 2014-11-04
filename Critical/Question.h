//
//  Question.h
//  Critical
//
//  Created by Lok on 04/11/2014.
//  Copyright (c) 2014 Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Set;

@interface Question : NSManagedObject

@property (nonatomic, retain) NSString * sentence;
@property (nonatomic, retain) Set *set;

@end
