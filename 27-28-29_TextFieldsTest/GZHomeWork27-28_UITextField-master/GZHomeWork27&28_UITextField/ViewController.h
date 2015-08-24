//
//  ViewController.h
//  GZHomeWork27&28_UITextField
//
//  Created by 3axap on 08.03.15.
//  Copyright (c) 2015 Garan Zakhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *eMailTextField;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *allTextFields;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *outputLabels;



- (IBAction)textEditingAction:(UITextField *)sender;
@end

