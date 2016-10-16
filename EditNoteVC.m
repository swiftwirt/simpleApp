//
//  EditNoteVC.m
//  SimpleCoreDataApp
//
//  Created by Ivashin Dmitry on 10/16/16.
//  Copyright © 2016 Ivashin Dmitry. All rights reserved.
//

#import "EditNoteVC.h"

@interface EditNoteVC ()

@end

@implementation EditNoteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.text = self.note;
}

- (IBAction)cancelBtn:(id)sender {
    [self.delegate userDidCancelEditNote:self note:_textField.text];
}

- (IBAction)doneBtn:(id)sender {
    [self.delegate userDidFinishEditing:self note:_textField.text];
}

@end
