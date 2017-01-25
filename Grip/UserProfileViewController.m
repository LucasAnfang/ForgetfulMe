//
//  UserProfileViewController.m
//  Grip
//
//  Created by luke anfang on 12/7/16.
//  Copyright © 2016 luke anfang. All rights reserved.
////lanfang@usc.edu

#import "UserProfileViewController.h"
#import "LocationDetailsModel.h"
@interface UserProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *EmailLabel;
@property (strong, nonatomic) LocationDetailsModel* locationDetailsModel;
@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _locationDetailsModel = [LocationDetailsModel sharedModel]; //set the text lables vals
    self.EmailLabel.text = [NSString stringWithFormat: @"Email: %@ ", [[[FIRAuth auth] currentUser] email]];
    [self resetScore];
}
-(void)viewDidAppear:(BOOL)animated {
    [self resetScore]; //reset the score to get the most recent
}
-(void) resetScore{ //score is number of location details * 1000 makes people want to post more :)
    int score = 1000 * [_locationDetailsModel numberOfLocationDetails];
    self.ScoreLabel.text = [NSString stringWithFormat: @"Score: %d ", score];
    self.ScoreLabel.alpha = 0; //score fades in and is dimmer than user email
    [UIView animateWithDuration:2.0 animations:^{
        self.ScoreLabel.alpha = 1;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)LogoutButtonPressed:(id)sender {
    //Firebase logout using authenticator
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        //display logout error
        [self DisplayErrorInMessage:@"Sign Out Error"];
        return;
    }
    //segue back to initial view
    [self performSegueWithIdentifier: @"UserProfileToInitial" sender:nil];
    
}
-(void)DisplayErrorInMessage:(NSString*)message{
    //alert if there is an error
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Invalid Signout"
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *action) { /* nothing */ }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
