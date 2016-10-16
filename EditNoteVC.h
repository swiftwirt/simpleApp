//
//  EditNoteVC.h
//  SimpleCoreDataApp
//
//  Created by Ivashin Dmitry on 10/16/16.
//  Copyright © 2016 Ivashin Dmitry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditNoteVC;

@protocol EditNoteVCDelegate <NSObject>
@required

-(void) userDidFinishEditing:(EditNoteVC *)controller note:(NSString *)note;

-(void) userDidCancelEditNote:(EditNoteVC *)controller note:(NSString *)note;

@end

@interface EditNoteVC : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (assign) id<EditNoteVCDelegate> delegate;

@property NSString *note;

@end
