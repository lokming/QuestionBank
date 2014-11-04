//
//  CRDetailViewController.m
//  Critical
//
//  Created by Lok on 29/07/2014.
//  Copyright (c) 2014 Chung. All rights reserved.
//

#import "CRDetailViewController.h"
#import "CRAppDelegate.h"
#import "Bank.h"
#import "Section.h"
#import "Subsection.h"
#import "CRMasterViewController.h"

@interface CRDetailViewController ()
- (void)configureView;
@end

#define kAlertNewTask 1002

@implementation CRDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        //self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
        self.title = [self.detailItem valueForKey:@"category"];
        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
                                                                                   action:@selector(insertNewObject:)];
        self.navigationItem.rightBarButtonItem = addButton;

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    //self.tableView.dataSource = self;
    //[self.tableView reloadData];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.tableView reloadData];
}

- (NSArray *)allSections
{
    NSSortDescriptor *division = [NSSortDescriptor sortDescriptorWithKey:@"division" ascending:YES];
    //NSSortDescriptor *group = [NSSortDescriptor sortDescriptorWithKey:@"group" ascending:YES];
    
    return [self.detailItem.thesection sortedArrayUsingDescriptors:@[division]];
}

- (void)insertNewObject:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Create Section"
                                                    message:@"Add a new section"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Save", nil];
    [alert setTag:kAlertNewTask];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kAlertNewTask && buttonIndex != alertView.cancelButtonIndex)
    {
        UITextField *textField = [alertView textFieldAtIndex:0];
        if ([textField.text length] == 0)
            return;
        //Question *newQuestion = [NSEntityDescription insertNewObjectForEntityForName:@"Question"
          //                                                    inManagedObjectContext:self.managedObjectContext];
        
        Section *newSection = [NSEntityDescription insertNewObjectForEntityForName:@"Section"
                                                      inManagedObjectContext:self.managedObjectContext];
        
        [newSection setValue:textField.text forKey:@"division"];
        //[newSection setValue:@"Q's which probe: Purpose" forKey:@"subsection"];
        //[newSection setValue:@("A") forKey:@"group"];
        //[newQuestion setValue:@(NO) forKey:@"completed"];
        
        [self.detailItem addThesectionObject:newSection];
        
        NSError *error = nil;
        if (![self.managedObjectContext save:&error])
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        [self.tableView reloadData];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"CRDetailVC - numberOfRowsInSection %lu",(unsigned long)[[self allSections] count]);
    return [[self allSections] count];
    //return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell"
                                                            forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Section *section = [[self allSections] objectAtIndex:indexPath.row];
    //NSString *addPicker = @"<noun>";
    
    //NSRange range;
    //range = [question.sentence rangeOfString: addPicker];
    //NSLog (@"found at index %lu", range.location);
    //NSLog (@"length = %lu", range.length);
    
    NSLog(@"CRDetailVC - The section item in cell %@", section.thesubsection);
    //BOOL completed = [[task valueForKey:@"completed"] boolValue];
    cell.textLabel.text = [section valueForKey:@"division"];
    //cell.detailTextLabel.text = [question valueForKey:@"group"];
    
    //if (completed)
    //  [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    //else
    //  [cell setAccessoryType:UITableViewCellAccessoryNone];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 /*   Task *task = [[self allTasks] objectAtIndex:indexPath.row];
   BOOL completed = [[task valueForKey:@"completed"] boolValue];
    [task setValue:@(!completed) forKey:@"completed"];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];*/
    //[self.tableView reloadData];
    // Question *question = [[self allQuestions] objectAtIndex:indexPath.row];
     Section *sections = [[self allSections] objectAtIndex:indexPath.row];
    
    /*Subsection *ssection = [NSEntityDescription insertNewObjectForEntityForName:@"Subsection"
                                                         inManagedObjectContext:self.managedObjectContext];
    
    [ssection setValue:@"Test1" forKey:@"subdivision"];
    [sections addSubsectionObject:ssection];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    */
    
    
    NSLog(@"CRDetailVC - Segue Section: %@", sections);
    [self performSegueWithIdentifier:@"subsectionSegue" sender:sections];
    

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"subsectionSegue"])
    {
        
       // NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //_detailItem = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        //NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    //_detailItem = [[self fetchedResultsController] objectAtIndexPath:indexPath];
       // NSLog(@"Bank before segue %@", detailItem);
        
        
        [[segue destinationViewController] setValue:sender forKey:@"section2"];
        [[segue destinationViewController] setValue:_detailItem forKey:@"detailItem2"];
        [[segue destinationViewController] setValue:self.managedObjectContext forKey:@"managedObjectContext"];
        //[[segue destinationViewController] setValue:self.fetchedResultsController forKey:@"fetchedResultsController"];
        //the above stops CRSection table to display
    }
    
    
    /*
    UIViewController *destination = segue.destinationViewController;
    //Question *question = [[self allQuestions] objectAtIndex:indexPath.row];
    if ([segue.identifier isEqualToString:@"questionSegue"])
        [destination setValue:sender forKeyPath:@"questions2"];
   else
        destination = [segue.destinationViewController topViewController];
    
    [destination setValue:self forKeyPath:@"delegate"];
    */
 
   /* if ([[segue identifier] isEqualToString:@"questionSegue"])
     {
     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     Bank *bank = [[self fetchedResultsController] objectAtIndexPath:indexPath];
     
     [[segue destinationViewController] setValue:bank forKey:@"detailItem"];
     [[segue destinationViewController] setValue:self.managedObjectContext forKey:@"managedObjectContext"];
     }*/
    }




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //NSManagedObjectContext *context = [ self.fetchedResultsController managedObjectContext];
        //[context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        Section *section = [[self allSections] objectAtIndex:indexPath.row];
        [self.managedObjectContext deleteObject:section];
        //[self.managedObjectContext is referring to Bank detailItem from MV
        
        NSError *error = nil;
        if (![self.managedObjectContext save:&error])
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
       
        [self setEditing:NO animated:YES];
        [self.tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
