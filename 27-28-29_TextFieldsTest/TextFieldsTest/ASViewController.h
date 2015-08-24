//
//  ASViewController.h
//  TextFieldsTest
//
//  Created by Oleksii Skutarenko on 13.12.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField* firstNameField;
@property (weak, nonatomic) IBOutlet UITextField* lastNameField;

@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *telefonField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;



@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *fields;

@property (assign, nonatomic) BOOL atPresent;

- (IBAction)actionLog:(id)sender;

- (IBAction)textfieldEditingAction:(UITextField *)textField;

- (IBAction)actionTextChanged:(UITextField *)sender;




@end
