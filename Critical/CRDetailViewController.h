//
//  CRDetailViewController.h
//  Critical
//
//  Created by Lok on 29/07/2014.
//  Copyright (c) 2014 Chung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Bank.h"

@interface CRDetailViewController : UITableViewController <NSFetchedResultsControllerDelegate>


@property (strong, nonatomic) Bank *detailItem;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
