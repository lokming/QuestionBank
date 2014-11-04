//
//  CRSectionVC.h
//  Critical
//
//  Created by Lok on 01/10/2014.
//  Copyright (c) 2014 Chung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Bank.h"
#import "Section.h"
#import "Subsection.h"

@interface CRSubsectionVC : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) Bank *detailItem2;
@property (strong, nonatomic) Section *section2;


//@property (strong, nonatomic) Section *section5;
@property (weak, nonatomic) Subsection *subsection;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
