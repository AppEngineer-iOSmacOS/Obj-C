//
//  ASViewController.m
//  TextFieldsTest
//
//  Created by Oleksii Skutarenko on 13.12.13.
//  Copyright (c) 2013 Sozinov Nikolay

/*
Итак начинаем текстовые поля. Напоминаю, этот элемент очень распространен и не очень простой, поэтому уделите ему должное внимание. Начнем с простого, а после урока номер 28 я добавлю задания уровней повыше.

Создаем форму для регистрации студента.

            
                 Сделано в сториборде - Ученик.

                1. Создайте поля (и лейблы напротив как в уроке): имя, фамилия, логин, пароль, возраст, телефон, имеил адрес.
                2. Установите правильные виды клавиатур для каждого текстового поля.
                3. У всех текстовых полей кроме последнего кнопка ретерн должна быть NEXT, а у последнего DONE.
                4. Осуществите переход по кнопкам NEXT и уберите клаву с экрана кнопкой DONE.
                5. Каждое поле при нажатии должно иметь кнопку очистки

Студент

6. Совет, чтобы осуществить переход по NEXT без проверки тонны пропертей, попробуйте использовать UIOutletCollection
7. Создайте соответствующие каждому текстовому полю UILabel чтобы выводить туда информацию из текстовых полей. Сделайте их мелкими и другого цвета.
8. По изменению текста (даже буквы) обновляйте эти лейблы (не забудте про CLEAR button)

Мастер

9. Для поля ввода телефона используйте мой код из видео, можете поместить его в какой-то оотдельный метод если надо
10. Этот код должен работать только для поля телефона и не для какого другого

Супермен

11. Для поля ввода имеила ограничте ввод символов недопустимых в адресе
12. Более того, сибвол "@" может быть введен только 1 раз
13. установите разумное ограничение для этого поля
//
 
 
 ****************************************
 Включен урок 29
 
 Задание:
 
 Ученик-Студент-Мастер-Супермен:
 
 1. Сделайте задания из уроков 27 и 28 используя статические ячейки.
 2. Добавьте возможность сохранять результат.
 3. Добавьте новые секции и ячейки с прочим контролами (свичи, сегменты, слайдеры) чтобы проработать материал
 
 Это все
 
  Не стал делать, т.к. проработал и так, промаявшись в дебагере в поисках ошибок и падений и отлично понял как все работает (закомментировал кусок заготовки для свичей, слайдеров и т.п.)
 */

#import "ASViewController.h"


typedef enum {
    
    TextFieldFirstName = 1,
    TextFieldLastName,
    TextFieldLogin,
    TextFieldPassword,
    TextFieldAge,
    TextFieldPhone,
    TextFieldEmail
    
} TextFieldType;

@interface ASViewController ()

@property (assign, nonatomic) int dogSymbolCount;

@end

static NSString* kSettingsFirstName   = @"firstName";
static NSString* kSettingsLastName    = @"lastName";
static NSString* kSettingsLogin       = @"login";
static NSString* kSettingsPassword    = @"password";
static NSString* kSettingsAge         = @"age";
static NSString* kSettingsPhone       = @"phone";
static NSString* kSettingsEmail       = @"email";



@implementation ASViewController



- (void)viewDidLoad

{
    [super viewDidLoad];
   [self loadSettings];

    
	self.dogSymbolCount = 0;
    
    //self.firstNameField.keyboardAppearance = UIKeyboardAppearanceDark;
    //self.lastNameField.keyboardAppearance = UIKeyboardAppearanceLight;
    
    [self.firstNameField becomeFirstResponder];
    
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(notificationTextDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [nc addObserver:self selector:@selector(notificationTextDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    [nc addObserver:self selector:@selector(notificationTextDidChangeEditing:) name:UITextFieldTextDidChangeNotification object:nil];
    
    
    [nc addObserver:self selector:@selector(notificationKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(notificationKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) notificationKeyboardWillShow:(NSNotification*) notification {
    
//    NSLog(@"notificationKeyboardWillShow:\n%@", notification.userInfo);
    
}

- (void) notificationKeyboardWillHide:(NSNotification*) notification {
    
//    NSLog(@"notificationKeyboardWillHide:\n%@", notification.userInfo);
    
}


- (void)updateLabelForTextField:(UITextField *)textField {
    
    switch (textField.tag) {
        case TextFieldFirstName:
            self.firstNameLabel.text = textField.text;
            break;
        case TextFieldLastName:
            self.lastNameLabel.text = textField.text;
            break;
        case TextFieldLogin:
            self.loginLabel.text = textField.text;
            break;
        case TextFieldPassword:
            self.passwordLabel.text = textField.text;
            break;
        case TextFieldAge:
            self.ageLabel.text = textField.text;
            break;
        case TextFieldPhone:
            self.phoneLabel.text = textField.text;
            break;
        case TextFieldEmail:
            self.emailLabel.text = textField.text;
            break;
        default:
            break;
    }
}



#pragma mark - Actions

- (IBAction)actionLog:(id)sender {
    
    NSLog(@"First Name = %@, Last Name = %@", self.firstNameField.text, self.lastNameField.text);
    
    if ([self.firstNameField isFirstResponder]) {
        [self.firstNameField resignFirstResponder];
    } else if ([self.lastNameField isFirstResponder]) {
        [self.lastNameField resignFirstResponder];
    }
}
    
    




- (BOOL)textFieldShouldReturn:(UITextField *)currentTextField {
    
    NSInteger currentTextFieldIndex = [self.fields indexOfObject:currentTextField];
    NSInteger lastTestFieldIndex = [self.fields indexOfObject:[self.fields lastObject]];
    
    if ((currentTextFieldIndex < self.fields.count) && (currentTextFieldIndex != lastTestFieldIndex)) {
        UITextField *nextTextField = [self.fields objectAtIndex:currentTextFieldIndex + 1];
        [nextTextField becomeFirstResponder];
    } else {
        [currentTextField resignFirstResponder];
    }
    
    
    return YES;
}


#pragma mark - Notifications

- (void) notificationTextDidBeginEditing:(NSNotification*) notification {
    NSLog(@"notificationTextDidBeginEditing");
}

- (void) notificationTextDidEndEditing:(NSNotification*) notification {
    NSLog(@"notificationTextDidEndEditing");
}

- (void) notificationTextDidChangeEditing:(NSNotification*) notification {
    NSLog(@"notificationTextDidChangeEditing");
}


#pragma mark - Actions



//-------

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
    [self updateLabelForTextField:textField];
    
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
    
    [self updateLabelForTextField:textField];
    
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
        
        self.ageLabel.textColor = [UIColor greenColor];
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
    
    [self updateLabelForTextField:textField];
    
    return NO;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if (textField.tag == TextFieldPhone) {
        
        [self textFieldPhoneNumber:textField shouldChangeCharactersInRange:range replacementString:string];
        return NO;
        
    } else if (textField.tag == TextFieldEmail) {
        
        [self textFieldEmail:textField shouldChangeCharactersInRange:range replacementString:string];
        return NO;
        
    }  else if (textField.tag == TextFieldAge) {
        
        [self textFieldAge:textField shouldChangeCharactersInRange:range replacementString:string];
        return NO;
    }
    
    else {
        
        
        return YES;
    }
    
}



#pragma mark - Save and Load

- (void) saveSettings {
   
    
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.firstNameField.text forKey:kSettingsFirstName];
    [userDefaults setObject:self.lastNameField.text forKey:kSettingsLastName];
    
    [userDefaults setObject:self.loginField.text forKey:kSettingsLogin];
//    [userDefaults setObject:self.passwordField.text forKey:kSettingsPassword];
    
    [userDefaults setObject:self.ageField.text forKey:kSettingsAge];
    [userDefaults setObject:self.telefonField.text forKey:kSettingsPhone];
    [userDefaults setObject:self.emailField.text forKey:kSettingsEmail];
   

    
    [userDefaults synchronize];
}

- (void) loadSettings {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.firstNameField.text = [userDefaults objectForKey:kSettingsFirstName];
    self.lastNameField.text = [userDefaults objectForKey:kSettingsLastName];
    
    self.loginField.text = [userDefaults objectForKey:kSettingsLogin];
//    self.passwordField.text = [userDefaults objectForKey:kSettingsPassword];
    
    
    self.ageField.text = [userDefaults objectForKey:kSettingsAge];
    self.telefonField.text = [userDefaults objectForKey:kSettingsPhone];
    self.emailField.text = [userDefaults objectForKey:kSettingsEmail];
    
}

- (IBAction)actionTextChanged:(UITextField *)sender {
    
    [self saveSettings];
}

//- (IBAction)actionValueChanged:(id)sender {
//    [self saveSettings];

// свичи, слайдеры и т.д.
//}


- (IBAction)textfieldEditingAction:(UITextField *)textField {
    [self updateLabelForTextField:textField];
    
    
}


@end
