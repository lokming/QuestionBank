//
//  CRDetailViewController.m
//  Critical
//
//  Created by Lok on 29/07/2014.
//  Copyright (c) 2014 Chung. All rights reserved.
//


#import "CRAppDelegate.h"
#import "Bank.h"
#import "Section.h"
#import "Subsection.h"
#import "CRDetailViewController.h"
#import "CRSubsectionVC.h"

@interface CRSubsectionVC ()
- (void)configureView;

@end

#define kAlertNewTask 1002

@implementation CRSubsectionVC

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{   [self configureView];
    if (_detailItem2 != newDetailItem) {
        _detailItem2 = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}




- (void)configureView
{
    // Update the user interface for the detail item.
    
    //if (self.detailItem) {
        //self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
       // self.title = _section2.section;
        self.title = @"This is the section";

        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
                                                                                   action:@selector(insertNewObject:)];
        self.navigationItem.rightBarButtonItem = addButton;
        
   // }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Subsection"];
    
    // Add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"subdivision" ascending:YES]]];
    
    // Initialize Fetched Results Controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    // Configure Fetched Results Controller
    [self.fetchedResultsController setDelegate:self];
    
    // Perform Fetch
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    NSLog(@"Fetch subsection - %@",_fetchedResultsController);
    
    //NSSet *subsect = _section2.thesubsection;
    //NSLog(@"CRSubsection - whats in section? %@",subsect);
    
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    //self.tableView.dataSource = self;
    //[self.tableView reloadData];
   /* Subsection *ssection = [NSEntityDescription insertNewObjectForEntityForName:@"Subsection"
                                                             inManagedObjectContext:self.managedObjectContext];
    
    [ssection setValue:@"Test1" forKey:@"subdivision"];
    [self.section5 addSubsectionObject:ssection];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    
    //NSLog(@"Whats in section5 %@", _section5);*/
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.tableView reloadData];
}

- (NSArray *)allQuestions
{
    //NSLog(@"Whats in section? %@", _section2.division);
    //NSSortDescriptor *division2 = [NSSortDescriptor sortDescriptorWithKey:@"division" ascending:YES];
    //return [self.detailItem2.thesection sortedArrayUsingDescriptors:@[division2]];
    
    //NSLog(@"Whats in section NSset the subsection- %@", [_section2 valueForKey:@"division"]);
    //NSSet *ss = section2.thesubsection;
    NSSortDescriptor *division = [NSSortDescriptor sortDescriptorWithKey:@"subdivision" ascending:YES];
    return [_section2.thesubsection sortedArrayUsingDescriptors:@[division]];
    //return self.section2.thesubsection;
    //NSSet *asWidgets = [subsection subsection];
    
    //return copy;
    
    //NSSortDescriptor *subdivision5 = [NSSortDescriptor sortDescriptorWithKey:@"division" ascending:YES];
    //return [self.detailItem2.section sortedArrayUsingDescriptors:@[subdivision5]];
    
    
    //NSSortDescriptor *division = [NSSortDescriptor sortDescriptorWithKey:@"division" ascending:YES];
    //return [self.detailItem2.section sortedArrayUsingDescriptors:@[division]];
}

- (void)insertNewObject:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Create Sub-section"
                                                    message:@"Add a new sub-section"
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
        
        _subsection = [NSEntityDescription insertNewObjectForEntityForName:@"Subsection"
                                                                inManagedObjectContext:self.managedObjectContext];
        
        //Subsection *subsection33 = [NSEntityDescription entityForName:@"Subsection" inManagedObjectContext:self.managedObjectContext];
        
        
        //Section *subsection33 = [NSEntityDescription insertNewObjectForEntityForName:@"Section"
          //                                                  inManagedObjectContext:self.managedObjectContext];
        
        [_subsection setValue:textField.text forKey:@"subdivision"];
        //[subsection setValue:@("A") forKey:@"group"];
        //[newQuestion setValue:@(NO) forKey:@"completed"];
        
        [self.section2 addThesubsectionObject:_subsection];
        
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
    //NSLog(@"CRSubsection numberOfRowsInSection in array %lu",(unsigned long)[[self allQuestions] count]);
    return [[self allQuestions] count];
    //return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subsectionCell"
                                                            forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil)
        return _fetchedResultsController;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Subsection"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"subdivision" ascending:NO];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                managedObjectContext:self.managedObjectContext
                                                                                                  sectionNameKeyPath:nil
                                                                                                           cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}



- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Update Cell
    //cell.textLabel.text = [record valueForKey:@"division"];
   
    //NSSortDescriptor *division = [NSSortDescriptor sortDescriptorWithKey:@"subdivision" ascending:YES];
    //return [self.section2.subsection sortedArrayUsingDescriptors:@[division]];

    //Subsection *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Update Cell
    //[cell.textLabel setText:[record valueForKey:@"subdivision"]];
    
   //_subsection = [[self allQuestions] objectAtIndex:indexPath.row];
   Subsection *subsection = [[self allQuestions] objectAtIndex:indexPath.row];
   
    //NSLog(@"Configure cell: %@", _subsection);
   cell.textLabel.text = [ subsection valueForKey:@"subdivision"];
    
    //NSLog(@"Configure cell: %@", _section2.division);
    //cell.textLabel.text = [ subsection valueForKey:@"division"];
    
    
    //This works to display eg "Purpose"
    //Section *subsection = [[self allQuestions] objectAtIndex:indexPath.row];
    //cell.textLabel.text = [subsection valueForKey:@"division"];
    
    
    //_section2 = [[self allQuestions] objectAtIndex:indexPath.row];
     //NSLog(@"CRSectionVC ----Cell: %@", question);
    
    //NSString *addPicker = @"<noun>";
    
    /*NSRange range;
    range = [question.sentence rangeOfString: addPicker];
    NSLog (@"found at index %lu", range.location);
    NSLog (@"length = %lu", range.length);
    */
    
    //NSLog(@"CRSectionVC In configureCell()----Cell: %@", subsection);
    
    //BOOL completed = [[task valueForKey:@"completed"] boolValue];
    
    //NSLog(@"CRSectionVC ----Cell: %@", _section2.subsection);
    
    
    //cell.textLabel.text = [ subsection valueForKey:@"subsection"];
    
    
    //cell.textLabel.text = [question valueForKey:@"subsection"];
    //cell.textLabel.text = @"Test";
    
    //cell.detailTextLabel.text = [_section2 valueForKey:@"group"];
    
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
    
    //_section2 = [[self allQuestions] objectAtIndex:indexPath.row];
    
    
    NSLog(@"CRSectionVC selected cell %@", _section2);
    //[self performSegueWithIdentifier:@"questionSegue" sender:questions];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"questionSegue"])
    {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //_detailItem = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        //NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        Bank *detailItem = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        NSLog(@"Bank before segue %@", detailItem);
        
        
        //[[segue destinationViewController] setValue:sender forKey:@"questions2"];
        //[[segue destinationViewController] setValue:detailItem forKey:@"detailItem2"];
        // [[segue destinationViewController] setValue:self.managedObjectContext forKey:@"managedObjectContext"];
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
        
        //Question *question = [[self allQuestions] objectAtIndex:indexPath.row];
        //[self.managedObjectContext deleteObject:question];
        //Turn back on
        
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
