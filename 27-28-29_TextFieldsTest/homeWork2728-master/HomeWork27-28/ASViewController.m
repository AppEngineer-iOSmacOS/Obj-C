//
//  ASViewController.m
//  HomeWork27-28
//
//  Created by Александр Карпов on 28.08.14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import "ASViewController.h"
#import "ASPhoneValidation.h"



@interface ASViewController ()



@end

@implementation ASViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //carateristic of Text Fields
    
    for (int i = 0; i < [self.fields count]; i++) {
        UITextField *textField = self.fields[i];
        
        self.typeField = textField.tag;
        
            switch (self.typeField) {
                case ASTypeFieldName:
                    
                    textField.returnKeyType = UIReturnKeyNext;
                    textField.clearButtonMode = UITextFieldViewModeUnlessEditing;
                    [textField becomeFirstResponder];
                    break;
                    
                case ASTypeFieldLastname:
                    
                    textField.returnKeyType = UIReturnKeyNext;
                    textField.clearButtonMode = UITextFieldViewModeUnlessEditing;
                    break;
                    
                case ASTypeFieldLogin:
                    
                    textField.returnKeyType = UIReturnKeyNext;
                    textField.clearButtonMode = UITextFieldViewModeUnlessEditing;
                    break;
                    
                case ASTypeFieldPassword:
                    
                    textField.returnKeyType = UIReturnKeyNext;
                    textField.clearButtonMode = UITextFieldViewModeUnlessEditing;
                    textField.secureTextEntry = YES;
                    
                    break;
                    
                case ASTypeFieldAge:
                    
                    textField.returnKeyType = UIReturnKeyNext;
                    textField.clearButtonMode = UITextFieldViewModeUnlessEditing;
                    textField.keyboardType = UIKeyboardTypeNumberPad;
                    break;
                    
                case ASTypeFieldPhoneNumber:
                    
                    textField.returnKeyType = UIReturnKeyNext;
                    textField.clearButtonMode = UITextFieldViewModeUnlessEditing;
                    textField.keyboardType = UIKeyboardTypePhonePad;
                    break;
                    
                case ASTypeFieldEmail:
                    
                    textField.returnKeyType = UIReturnKeyDone;
                    textField.clearButtonMode = UITextFieldViewModeUnlessEditing;
                    textField.keyboardType = UIKeyboardTypeEmailAddress;
                    break;
                    
                    
                default:
                    break;

        }
    
   
    }

    
}

#pragma mark - Sender Methods

- (IBAction)fieldChange:(UITextField *)sender {
    
    [self setValueForChangeableLabel:sender];
    
}



- (NSString*) setValueForChangeableLabel:(UITextField *)sender {
    
    self.typeField = sender.tag;
    
    switch (self.typeField) {
        case ASTypeFieldName:
            
            self.nameLabel.text = sender.text;
            break;
            
        case ASTypeFieldLastname:
            
            self.lastnameLabel.text = sender.text;
            break;
            
        case ASTypeFieldLogin:
            
            self.loginLabel.text = sender.text;
            break;
            
        case ASTypeFieldPassword:
            
            self.passwordLabel.text = sender.text;
            break;
            
        case ASTypeFieldAge:
            
            self.ageLabel.text = sender.text;
            break;
            
        case ASTypeFieldPhoneNumber:
            
            self.phoneNumberLabel.text = sender.text;
            break;
            
        case ASTypeFieldEmail:
            
            self.emailLabel.text = sender.text;
            break;
            
            
            
        default:
            break;
    }
    
    return 0;
}

#pragma mark - Format for Email, Phone Number and Age

- (BOOL) textFieldPhoneNumber:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray * components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    newString = [validComponents componentsJoinedByString:@""];
    
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countryCodeMaxLength = 3;
    
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
        return NO;
    }
    
    NSMutableString *resultString = [NSMutableString string];
    
    
    NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
    
    if (localNumberLength > 0) {
        NSString *number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
        [resultString appendString:number];
        if ([resultString length] >3) {
            [resultString insertString:@"-" atIndex:3];
        }
    }
    
    if ([newString length] > localNumberMaxLength) {
        NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
        NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
        NSString *area = [newString substringWithRange:areaRange];
        area = [NSString stringWithFormat:@"(%@)",area];
        [resultString insertString:area atIndex:0];
    }
    
    if ([newString length] > countryCodeMaxLength + localNumberMaxLength) {
        NSInteger countryCodeLength = MIN((int)[newString length] - countryCodeMaxLength - localNumberMaxLength, countryCodeMaxLength);
        NSRange areaRangeCountry = NSMakeRange((int)[newString length] - countryCodeMaxLength - localNumberMaxLength - countryCodeLength, countryCodeLength);
        NSString *area = [newString substringWithRange:areaRangeCountry];
        area = [NSString stringWithFormat:@"+%@ ",area];
        [resultString insertString:area atIndex:0];
    }
    
    
    textField.text = resultString;
    [self setValueForChangeableLabel:textField];
    
    return NO;

}



- (BOOL)textFieldEmail:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    
    NSCharacterSet *validation = [NSCharacterSet characterSetWithCharactersInString:@"!~!#$%^,/|&*()<>=+{}][:;'\" \\"];
    
    NSArray * components = [string componentsSeparatedByCharactersInSet:validation];

    
    if ([components count] > 1) {
        return NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (([newString rangeOfString:@"@"].length) < 1) {
        self.atPresent = NO;
    }
    
    if ([newString length] < 2 && [string isEqualToString:@"@"]) {
        
        return NO;
    }
    
    if (self.atPresent && [string isEqualToString:@"@"]) {
        return NO;
    }
    
    if ([string isEqualToString:@"@"]) {
        self.atPresent = YES;
    }

    textField.text = newString;
    
    [self setValueForChangeableLabel:textField];
    
    return NO;
    
}



- (BOOL)textFieldAge:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *validation = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    NSArray * components = [string componentsSeparatedByCharactersInSet:validation];
    
    if ([components count] > 1) {
        return NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([newString intValue] < 18) {
        
        self.ageLabel.textColor = [UIColor redColor];
        self.ageLabel.text = @"you need to be at least 18 years";
        textField.text = newString;
        return NO;
        
    } else if ([newString intValue] > 120) {
        
        self.ageLabel.textColor = [UIColor redColor];
        self.ageLabel.text = @"Your age is too big";
        textField.text = newString;
        return NO;
        
    } else {
        
        textField.text = newString;
        self.ageLabel.textColor = [UIColor blackColor];
    
    }
    
    [self setValueForChangeableLabel:textField];
    
    return NO;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if (textField.tag == ASTypeFieldPhoneNumber) {
        
        [self textFieldPhoneNumber:textField shouldChangeCharactersInRange:range replacementString:string];
        return NO;
        
    } else if (textField.tag == ASTypeFieldEmail) {
        
        [self textFieldEmail:textField shouldChangeCharactersInRange:range replacementString:string];
        return NO;
        
    }  else if (textField.tag == ASTypeFieldAge) {
        
        [self textFieldAge:textField shouldChangeCharactersInRange:range replacementString:string];
        return NO;
    }
    
    else {
        
        
        return YES;
    }
    
}



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    for (int i = 0; i < [self.fields count]-1; i++) {
        if ([textField isEqual:self.fields[i]]) {
            [self.fields[i+1] becomeFirstResponder];
            
        } else {
            [textField resignFirstResponder];
        }
    }
    
    
 return YES;
    

}
#pragma mark - Other methods


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
