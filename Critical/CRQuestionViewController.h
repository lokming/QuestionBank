//
//  CRQuestionViewController.h
//  Critical
//
//  Created by Lok on 13/08/2014.
//  Copyright (c) 2014 Chung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "Bank.h"

@interface CRQuestionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *questionTextfield;
@property (weak, nonatomic) NSString *sentence;
@property (strong, nonatomic) Bank *detailItem2;
@property (weak, nonatomic) Question *questions2;
@property (weak, nonatomic) id delegate;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


- (IBAction)close:(id)sender;
- (IBAction)saveQuestion:(id)sender;

@end
