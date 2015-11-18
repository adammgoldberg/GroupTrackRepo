//
//  GroupViewController.m
//  GroupTrack App
//
//  Created by Adam Goldberg on 2015-11-17.
//  Copyright © 2015 Adam Goldberg. All rights reserved.
//

#import "GroupViewController.h"
#import "Person.h"
#import "Group.h"
#import "Leader.h"
#import "Event.h"
#import "PersonCollectionViewCell.h"

@interface GroupViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segControlGroup;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewGroup;

@property (strong, nonatomic) NSMutableArray *listOfPersons;

@property (strong, nonatomic) NSMutableArray *listOfEvents;

@property (strong, nonatomic) NSMutableArray *listOfGroups;

@property (strong, nonatomic) NSMutableArray *currentGroup;

@property (strong, nonatomic) NSArray *sortGroup;

@property (strong, nonatomic) NSMutableArray *listOfLeaders;




@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listOfLeaders = [[NSMutableArray alloc] init];
    NSFetchRequest *leaderFetch = [NSFetchRequest fetchRequestWithEntityName:@"Leader"];
    NSError *error;
    [self.listOfLeaders addObjectsFromArray:[self.managedObjectContext executeFetchRequest:leaderFetch error:&error]];

// IF I WANT TO ADD EMAIL TEMPLATES FOR TEACHERS OR SOMETHING ELSE, THIS IS WHAT NEEDS TO BE DONE
//    if (self.listOfTeachers.count == 0) {
//        Teacher *aTeacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:self.managedObjectContext];
    
//        aTeacher.emailTemplateBad = @"Dear <Title> <Parent>,\n\nI wanted to inform you that <Student> disrupted class <Selected Number> times today. It would be greatly appreciated if you could please remind <Student> the importance of participating positively in class and being respectful to the teacher and other students. Thank you for your time and help.\n\nSincerely,\nYOUR NAME HERE\n\n\nSent via ClassTrack\nClassTrack - The Teacher Friendly Email Service";
// ETC
//        NSError *error;
//        [self.managedObjectContext save:&error];
//        
//        NSFetchRequest *teacherFetch = [NSFetchRequest fetchRequestWithEntityName:@"Teacher"];
//        [self.listOfTeachers addObjectsFromArray:[self.managedObjectContext executeFetchRequest:teacherFetch error:&error]];
//    }
    

    
    
    
    
    [self fetchPersonsAndEventsAndGroups];
    
    [self rebuildSegControl];
    
    [self.segControlGroup setSelectedSegmentIndex:0];
    [self classSelected:self.segControlGroup];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDataModelChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.managedObjectContext];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSInteger selectedIndex = [self.segControlGroup selectedSegmentIndex];
    if (selectedIndex == -1) {
        [self.segControlGroup setSelectedSegmentIndex:0];
        selectedIndex = 0;
    }
    NSString *titleString = [self.segControlGroup titleForSegmentAtIndex:selectedIndex];
    self.currentGroup = [[NSMutableArray alloc] init];
    for (Person *person in self.listOfPersons) {
        if (person.group.name == titleString) {
            [self.currentGroup addObject:person];
        }
    }
    [self.collectionViewGroup reloadData];
}

- (void)handleDataModelChange:(NSNotification *)note
{
    
    [self fetchPersonsAndEventsAndGroups];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:NO];
    self.sortGroup = @[sort];
    
    [self.currentGroup sortUsingDescriptors:self.sortGroup];
    
    [self.collectionViewGroup reloadData];
    
    [self rebuildSegControl];
}


#pragma mark - buttons and segs

- (IBAction)resetNumbers:(UIButton *)sender
{
    for (Person *aPerson in self.currentGroup) {
        aPerson.numberOfNegatives = 0;
        aPerson.numberOfPositives = 0;
    }
    [self.collectionViewGroup reloadData];
    
    NSError *error;
    [self.managedObjectContext save:&error];
    
}


- (IBAction)classSelected:(UISegmentedControl *)sender {
    
    NSString *gradeTitle = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    self.currentGroup = [[NSMutableArray alloc] init];
    for (Person *person in self.listOfPersons) {
        if (person.group.name == gradeTitle) {
            [self.currentGroup addObject:person];
        }
    }
    [self.collectionViewGroup reloadData];
}

- (void) rebuildSegControl;
{
    [self.segControlGroup removeAllSegments];
    
    if (self.listOfGroups.count > 0) {
        for (Group *group in self.listOfGroups) {
            [self.segControlGroup insertSegmentWithTitle:group.name atIndex:0 animated:NO];
        }
    } else {
        [self.segControlGroup insertSegmentWithTitle:@"Group" atIndex:0 animated:true];
    }
}


#pragma mark - collectionview






- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.currentGroup.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


-(void)configureCell:(PersonCollectionViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:recognizer];
    }
    
    Person *person = self.currentGroup[indexPath.row];
    cell.personName.text = person.firstName;
    
    CGFloat numberOfTaps = [person.numberOfNegatives integerValue];
    cell.positiveLabel.tag = indexPath.row;
    cell.negativeLabel.tag = indexPath.row;
    cell.layer.cornerRadius = 15;
    cell.layer.masksToBounds = YES;
    
    if ((numberOfTaps > 0) && (numberOfTaps <= 3)) {
        cell.backgroundColor = [UIColor colorWithRed:214/255.0f green:214/255.0f blue:0/255.0f alpha:1];
    } else if ((numberOfTaps > 3) && (numberOfTaps <= 6)) {
        cell.backgroundColor = [UIColor orangeColor];
    } else if (numberOfTaps > 6) {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:47/255.0f green:187/255.0f blue:48/255.0f alpha:1];
    }
    
    UITapGestureRecognizer *badTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(badPress:)];
    [cell.negativeLabel addGestureRecognizer:badTap];
    
    UITapGestureRecognizer *goodTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goodPress:)];
    [cell.positiveLabel addGestureRecognizer:goodTap];
    
    

    
}


-(void)badPress:(UITapGestureRecognizer*)tap
{

    NSLog(@"bad tap");
    Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    event.time = [NSDate date];
    Person *thePerson = self.currentGroup[tap.view.tag];
    [thePerson addEventsObject:event];
    NSError *error;
    [self.managedObjectContext save:&error];
    
    NSInteger numberOfBadPresses = [thePerson.numberOfNegatives integerValue];
    numberOfBadPresses = numberOfBadPresses + 1;
    NSNumber *newNumber = [NSNumber numberWithInteger:numberOfBadPresses];
    thePerson.numberOfNegatives = newNumber;
    
    
    [self fetchPersonsAndEventsAndGroups];

    [self.managedObjectContext save:&error];
    
}

-(void)goodPress:(UITapGestureRecognizer*)tap
{
    NSLog(@"good tap");
    Event *goodEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    goodEvent.time = [NSDate date];
    goodEvent.type = @"good";
    Person *thePerson = self.currentGroup[tap.view.tag];
    [thePerson addEventsObject:goodEvent];
    NSError *error;
    [self.managedObjectContext save:&error];
    
    NSInteger numberOfGoodPresses = [thePerson.numberOfPositives integerValue];
    numberOfGoodPresses = numberOfGoodPresses + 1;
    NSNumber *goodNumber = [NSNumber numberWithInteger:numberOfGoodPresses];
    thePerson.numberOfPositives = goodNumber;
    
    
    [self fetchPersonsAndEventsAndGroups];
    
    [self.managedObjectContext save:&error];

    
}





#pragma mark - fetches

-(void)fetchPersonsAndEventsAndGroups
{
    self.listOfPersons = [[NSMutableArray alloc] init];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:NO]];
    
    NSError *error;
    
    [self.listOfPersons addObjectsFromArray:[self.managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    
    
    self.listOfEvents = [[NSMutableArray alloc] init];
    
    NSFetchRequest *eventFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
    
    NSError *eventError;
    
    [self.listOfEvents addObjectsFromArray:[self.managedObjectContext executeFetchRequest:eventFetchRequest error:&eventError]];
    
    
    self.listOfGroups = [[NSMutableArray alloc] init];
    
    NSFetchRequest *groupFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Group"];

    
    NSError *groupError;
    
    [self.listOfGroups addObjectsFromArray:[self.managedObjectContext executeFetchRequest:groupFetchRequest error:&groupError]];
    
}



@end
