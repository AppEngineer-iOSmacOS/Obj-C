//
//  ViewController.m
//  testLimun
//
//  Created by Nikolay Sozinov on 23.09.15.
//  Copyright © 2015 Nikolay Sozinov. All rights reserved.
//

#import "ViewController.h"
#import "UIViewControllerProfile.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a ni
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - loadProfile

//загружаем Профиль
- (void) showControllerAsModal:(UIViewController*)vc {
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav
                       animated:YES
                     completion:^{nil;}];
    
}

#pragma mark - Actions

- (IBAction)exitAction:(UIButton *)sender {
    

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Внимание!"
                                                    message:@"Сейчас вы выйдете из Профиля: Либо через отмену произойдет перезагрузка, либо откроется внешняя ссылка на сайт"
                                                   delegate:self
                                          cancelButtonTitle:@"Выйти"
                                          otherButtonTitles:@"Открыть сайт",nil];
    [alert show];
    
  
   
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"Cancel Tapped.");
//уничтожаем Профиль
        self.view = nil;
        
// создаем и загружаем приложение заново с анимацией
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"login"];
        [self presentModalViewController:vc animated:YES];
        
    }
    else if (buttonIndex == 1) {
        NSLog(@"OK Tapped. Открываю ссылку");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sozinov.pro"]];
    
    }
    
}

-(void) dealloc {

    NSLog(@"dealloc test");
}


- (IBAction)actionEnter:(id)sender {
    
//    захватываю логин и пароль и отправляю методу autorezationUser для авторизации
    NSLog(@"action Enter login = %@, pass = %@", self.loginTextField.text, self.passwordTextField.text);
    [self autorezationUser:_loginTextField and:_passwordTextField];
   }

// возврат из меню напоминания пароля
- (IBAction)actionBack:(id)sender {
    NSLog(@"action More");
}

#pragma mark - textFildNextDone
//метод перехода из логина в пароль по кнопке NEXT и скрытие клавиатуры по DONE

- (BOOL)textFieldShouldReturn:(UITextField*)textField{
    
    if ([textField isEqual:self.loginTextField]) {
        [self.passwordTextField becomeFirstResponder];
    }else {[textField resignFirstResponder];
    }

    return YES;
}

#pragma mark - Metod autorization
// приходит логин и пароль из actionEnter, данные должны отправиться на сервер для проверки...http://testme.dev.amict.ru/datapoint.php
// с сервера возвращается Ошибка, либо Положительный ответ
//если положительный ответ то перейти на страницу ОК - Профиль. а в нем загрузить XML с данными.

- (BOOL) autorezationUser:(NSString *)loginString and:(NSString*)passordString{
    
    UIViewControllerProfile* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"loginOk"];
    [self showControllerAsModal:vc];
    
    NSLog(@"metod autorezationUser");
   
    return YES; //YES поставил для тестирования

}


@end
