//
//  ASViewController.h
//  HomeWork27-28
//
//  Created by Александр Карпов on 28.08.14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ASTypeFieldName,
    ASTypeFieldLastname,
    ASTypeFieldLogin,
    ASTypeFieldPassword,
    ASTypeFieldAge,
    ASTypeFieldPhoneNumber,
    ASTypeFieldEmail
    
} ASTypeField;

@interface ASViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *fields;

@property (assign, nonatomic) ASTypeField typeField;

@property (assign, nonatomic) BOOL atPresent;

- (IBAction)fieldChange:(UITextField *)sender;


@end
