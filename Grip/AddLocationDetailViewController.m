//
//  AddLocationDetailViewController.m
//  Grip
//
//  Created by luke anfang on 12/6/16.
//  Copyright © 2016 luke anfang. All rights reserved.
////lanfang@usc.edu

#import "AddLocationDetailViewController.h"
//delegates
@interface AddLocationDetailViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *titleField;

@end

@implementation AddLocationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _saveButton.enabled = false; //cant save after loading in
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder]; //nice way to get rid of keyboard after typing in TF
    return YES;
}
- (BOOL)textViewShouldReturn:(UITextView *)textView{
    [textView resignFirstResponder];
    //return in the text view fires completion handler
    if (self.completionHandler) {
        self.completionHandler(self.titleField.text, self.descriptionTextView.text);
    }
    //set the data in fields to nil to clear it out before exit
    self.titleField.text = nil;
    self.descriptionTextView.text = nil;
    
    return YES;
}
-  (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.titleField resignFirstResponder]; //get rid of keyboard
    //[self.descriptionTextView resignFirstResponder];
}
- (void) enableSaveButtonForLocationDetail: (NSString *) titleText answer: (NSString *) descriptionText{
    NSLog(@"%s",(titleText.length > 0 && descriptionText.length > 0) ? "true":"false");
    self.saveButton.enabled = (titleText.length > 0 && descriptionText.length > 0); //check if data is in fields to see if the save should be enabled
}
- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString* changedString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    [self enableSaveButtonForLocationDetail:self.titleField.text answer:changedString];
    return YES;
    //moniter textview changes
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self.titleField resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
    //if cancel is tapped it fires the completion handler but with empty data This does nothing because the data is nil as see in viewcontroller.m
    //completion handler
    if (self.completionHandler) {
        self.completionHandler(nil,nil);
    }
    //clear fields
    self.titleField.text = nil;
    self.descriptionTextView.text = nil;
}
- (IBAction)saveButtonTapped:(id)sender {
    [self.titleField resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
    //fire completion handler with field data 
    //completion handler
    if (self.completionHandler) {
        self.completionHandler(self.titleField.text, self.descriptionTextView.text);
    }
    //clear fields
    self.titleField.text = nil;
    self.descriptionTextView.text = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
