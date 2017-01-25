//
//  SignupViewController.m
//  Grip
//
//  Created by luke anfang on 12/7/16.
//  Copyright © 2016 luke anfang. All rights reserved.
////lanfang@usc.edu

#import "SignupViewController.h"

@interface SignupViewController ()
//All needed properties being the text fields
@property (weak, nonatomic) IBOutlet UITextField *FirstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *LastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *ConfirmPasswordTextField;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SignupButtonPressed:(id)sender {
    if(![self hasNoEmptyFields]){ //check if the fields are filled
        [self DisplayErrorInMessage:@"Field Empty"]; //display error message dont proceed with signup
        return;
    }
    if(![self.PasswordTextField.text isEqualToString: self.ConfirmPasswordTextField.text]){ //check if confirm and regular passwords match
        [self DisplayErrorInMessage:@"Passwords Do not match"]; //display error message dont proceed with signup
        return;
    }
    //firebase signup authentication
    [[FIRAuth auth]
     createUserWithEmail:self.EmailTextField.text
     password:self.PasswordTextField.text
     completion:^(FIRUser *_Nullable user,
                  NSError *_Nullable error) {
                        if(error != nil){
                            //there is an error
                            //do not proceed and display error
                            [self DisplayErrorInMessage:error.localizedDescription];
                        } else{
                            //segue to main (successful signup)
                            [self performSegueWithIdentifier: @"SignUpToMain" sender:nil];
                        }
        
     }];
}

-(void)DisplayErrorInMessage:(NSString*)message{ //display error message using uialerts with custom message
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Invalid Signup"
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action) { /* nothing */ }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(Boolean) hasNoEmptyFields{ //check if fields are filled
    return (self.FirstNameTextField.hasText && self.LastNameTextField.hasText &&
            self.EmailTextField.hasText && self.PasswordTextField.hasText &&
            self.ConfirmPasswordTextField.hasText);
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     //Get the new view controller using [segue destinationViewController].
     //Pass the selected object to the new view controller.
}


@end
