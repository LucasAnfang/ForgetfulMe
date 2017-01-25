//
//  LoginViewController.m
//  Grip
//
//  Created by luke anfang on 12/7/16.
//  Copyright © 2016 luke anfang. All rights reserved.
////lanfang@usc.edu

#import "LoginViewController.h"

@interface LoginViewController ()
//Email and password fields needed as properties
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)LoginButtonPressed:(id)sender {
    if(![self hasNoEmptyFields]){ //check if the fields are empty
        [self DisplayErrorInMessage:@"Field Empty"];//if they are display error message in an alert and dont call firebase auth
        return;
    }
    //this is firebases authenticator
    [[FIRAuth auth] signInWithEmail:self.EmailTextField.text
                           password:self.PasswordTextField.text
                         completion:^(FIRUser *user, NSError *error) {
                             if(error != nil){
                                 //if there is an error it comes here and displays the error in an alert
                                 [self DisplayErrorInMessage:error.localizedDescription];
                             }else{
                                 //segue to next view controller Main after successful login
                                  [self performSegueWithIdentifier:@"LoginToMain" sender:nil];
                             }
    }];
}
-(void)DisplayErrorInMessage:(NSString*)message{ //This is the display error message function using uialerts
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Invalid Login"
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *action) { /* nothing */ }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(Boolean) hasNoEmptyFields{ //checks if there is data in both fields
    return (self.EmailTextField.hasText && self.PasswordTextField.hasText);
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
