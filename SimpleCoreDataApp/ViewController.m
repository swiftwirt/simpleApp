//
//  ViewController.m
//  SimpleCoreDataApp
//
//  Created by Ivashin Dmitry on 10/16/16.
//  Copyright © 2016 Ivashin Dmitry. All rights reserved.
//

#import "ViewController.h"
#import "EditNoteVC.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, EditNoteVCDelegate>

@property NSMutableArray *notesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Add note";
    _notesArray = [NSMutableArray array];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - tableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_notesArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *note = _notesArray[indexPath.row];
    cell.textLabel.text = note;
    return cell;
}

//MARK: - tableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

//MARK: - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"EditNote"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSString *note = _notesArray[indexPath.row];
        [_notesArray removeObjectAtIndex:indexPath.row];
        UINavigationController *naviController = (UINavigationController *)segue.destinationViewController;
        EditNoteVC *editController = naviController.viewControllers[0];
        editController.delegate = self;
        editController.note = note;
    }
}

//MARK: - editVC delegate

-(void) userDidCancelEditNote:(EditNoteVC *)controller note:(NSString *)note {
    [self.notesArray addObject:note];
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void) userDidFinishEditing:(EditNoteVC *)controller note:(NSString *)note {
    [self.notesArray addObject:note];
    [self dismissViewControllerAnimated:true completion:nil];
}

//MARK: - actions

- (IBAction)addNote:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter note text!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Note description...";
        textField.textColor = [UIColor darkGrayColor];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alert.textFields;
        UITextField * field = textfields[0];
        NSString *note = [NSString stringWithFormat:@"%@", field.text];
        [self.notesArray addObject:note];
        [self.tableView reloadData];
        NSLog(@"*****%@", [_notesArray description]);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
