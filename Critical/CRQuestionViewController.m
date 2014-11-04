//
//  CRQuestionViewController.m
//  Critical
//
//  Created by Lok on 13/08/2014.
//  Copyright (c) 2014 Chung. All rights reserved.
//

#import "CRQuestionViewController.h"
#import "CRDetailViewController.h"
#import "CRAppDelegate.h"
#import "Bank.h"
#import "Question.h"
#import "CRMasterViewController.h"

@interface CRQuestionViewController ()

@end

@implementation CRQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Question *question = [[self allQuestions] objectAtIndex:indexPath.row];
    
    //BOOL completed = [[task valueForKey:@"completed"] boolValue];
    //self.questionTextfield.text = @"question";
     NSLog(@"The seleected question to view %@", _questions2);
    //self.questionTextfield.text = self.sentence;
    self.questionTextfield.text = _questions2.sentence;
   
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveQuestion:(id)sender {
    
    //UITextField *textField = [alertView textFieldAtIndex:0];
    if ([_questionTextfield.text length] == 0)
        return;
    
    [_questions2 setValue:_questionTextfield.text forKey:@"sentence"];
    [_questions2 setValue:@("B") forKey:@"group"];
    
    NSLog(@"Did the question change? %@", _questions2);
    //[newQuestion setValue:@(NO) forKey:@"completed"];
    
    //NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    //[context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    
    //[self.detailItem2 addQuestionObject:_questions2];
    // [self.managedObjectContext deleteObject:_questions2];
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    if (![self.managedObjectContext save:&error])
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    NSLog(@"Question after SAVE %@", _questions2);

    //[self.tableView reloadData];
   // NSLog(@"Whats in Bank? %@", _detailItem2);
    [self close:sender];
}

- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}



@end
