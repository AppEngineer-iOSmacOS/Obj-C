//
//  ViewController.h
//  testLimun
//
//  Created by Nikolay Sozinov on 23.09.15.
//  Copyright © 2015 Nikolay Sozinov. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITextFieldDelegate>




@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *remindPassword;

- (IBAction)exitAction:(UIButton *)sender;

- (IBAction)actionEnter:(id)sender;

- (IBAction)actionBack:(id)sender;
- (void) autorezationUser:(NSString *)loginString and:(NSString*)passordString;

@end

