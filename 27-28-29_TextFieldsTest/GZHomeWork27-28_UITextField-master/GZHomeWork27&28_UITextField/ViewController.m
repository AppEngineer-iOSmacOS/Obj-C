//
//  ViewController.m
//  GZHomeWork27&28_UITextField
//
//  Created by 3axap on 08.03.15.
//  Copyright (c) 2015 Garan Zakhar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)textEditingAction:(UITextField *)sender {//при зміні тексту у всіх UITextField
    
    UILabel* currentLabel=[self.outputLabels objectAtIndex:[self.allTextFields indexOfObject:sender]];//створення вказівника на UILabel з масиву всіх UILabel за індексом UITextField, в якому відбулися зміни
    
    currentLabel.text=sender.text;//присвоєння тексту з UITextField, в якому відбулися зміни, у відповідний UILabel
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {//що відбуваєтсья при натисканні кнопки "Return" (в даних випадках вона "Next" та "Done"
    
    for (int i=0; i<[self.allTextFields count]; i++) {
        
        if (i==[self.allTextFields count]-1) {//якщо це останній UITextField -
            [textField resignFirstResponder];//при натисканні Done зняти фокус з нього, що заховає клавіатуру
            break;}
        
        if ([[self.allTextFields objectAtIndex:i] isEqual:textField]) [[self.allTextFields objectAtIndex:i+1] becomeFirstResponder];//при натисканні Next перемістити фокус на наступний UITextField
    }
        return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {//при внесенні нового символу (символів) в UITextField
    
    //age
    if ([textField isEqual:[self.allTextFields objectAtIndex:2]]){//якщо це поле вводу віку
        
        NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];//набір усіх символів крім чисел
        NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];//розідлити введений текст символами з набору validationSet
        
        if ([components count] > 1) {//якщо розділених частин більше ніж 1 (тобто був введений символ з набору validationSet) -
            return NO;//не вносити його до тексту, повернути NO
        }
        
        NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];//створюємо рядок з уже введених символів та нових

        if ([newString length]>2) return NO;//якщо їз разом більше 2 - не вносити його до тексту, повернути NO
    }
    
    //e-mail
    if ([textField isEqual:[self.allTextFields objectAtIndex:6]]){//якщо це поле вводу e-mail
        
        NSMutableCharacterSet* validationSet = [NSMutableCharacterSet decimalDigitCharacterSet];//створити набір символів з цифр
        [validationSet formUnionWithCharacterSet:[NSMutableCharacterSet letterCharacterSet]];//обєднати з набором букв
        [validationSet addCharactersInString:@"-.@_"];//додати ще символи
        [validationSet invert];//інвертувати (тобто в ньому будуть усі символи, окрім тих що зазначені вище
                                                
        NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];//розділити на кілька рядків нові введені символи
        
        NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];//рядок уже введених + нові символи

        NSArray* componentsWithAt = [newString componentsSeparatedByString:@"@"];//розділити увесь рядок символом "@"
        
        if ([components count] > 1 || [componentsWithAt count]>2 || [newString length]>20) {//якщо вдалось розділити нові символи на більш ніж 1 елемент (отже там є заборонені символи) або там є два символи @ або довжина рядка більше 20 символів
            return NO; //не вносити нові набрані символи до тексту, повернути NO
        }
    }
    
    //phone number
    if ([textField isEqual:[self.allTextFields objectAtIndex:5]]){//якщо це поле вводу номеру телефону
        
    //код Олексія Скутаренка
    NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;
    }
    
    NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    
    newString = [validComponents componentsJoinedByString:@""];
    
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countryCodeMaxLength = 3;
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
        return NO;
    }
    
    NSMutableString* resultString = [NSMutableString string];
    
    NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
    
    if (localNumberLength > 0) {
        
        NSString* number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
        
        [resultString appendString:number];
        
        if ([resultString length] > 3) {
            [resultString insertString:@"-" atIndex:3];
        }
    }
    
    if ([newString length] > localNumberMaxLength) {
        
        NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
        
        NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
        
        NSString* area = [newString substringWithRange:areaRange];
        
        area = [NSString stringWithFormat:@"(%@) ", area];
        
        [resultString insertString:area atIndex:0];
    }
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
        
        NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
        
        NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
        
        NSString* countryCode = [newString substringWithRange:countryCodeRange];
        
        countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
        
        [resultString insertString:countryCode atIndex:0];
    }
    
    textField.text = resultString;
        
        UILabel* currentLabel=[self.outputLabels objectAtIndex:5];
        currentLabel.text=resultString;
    
    return NO;
    }
    
    else return YES;//у всіх інших випадках обмежень на ввід символів немає
}

@end
