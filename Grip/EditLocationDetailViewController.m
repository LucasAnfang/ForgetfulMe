//
//  EditLocationDetailViewController.m
//  Grip
//
//  Created by luke anfang on 12/7/16.
//  Copyright © 2016 luke anfang. All rights reserved.
////lanfang@usc.edu

#import "EditLocationDetailViewController.h"

@interface EditLocationDetailViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *titleField;

@end

@implementation EditLocationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _saveButton.enabled = true; //user can save without changing data
    self.descriptionTextView.text = self.originalDescription; //set the text with the original data
        self.titleField.text = self.originalTitle;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder]; //keyboard remove after editing
    return YES;
}
- (BOOL)textViewShouldReturn:(UITextView *)textView{
    [textView resignFirstResponder];//keyboard remove after editing
    //fire completion handler after return is pressed
    if (self.completionHandler) {
        self.completionHandler(self.titleField.text, self.descriptionTextView.text);
    }
    
    self.titleField.text = nil;
    self.descriptionTextView.text = nil;
    
    return YES;
}
-  (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.titleField resignFirstResponder];
    //[self.descriptionTextView resignFirstResponder];
}
- (void) enableSaveButtonForLocationDetail: (NSString *) titleText answer: (NSString *) descriptionText{
    NSLog(@"%s",(titleText.length > 0 && descriptionText.length > 0) ? "true":"false");
    //check if the save button should be enabled
    self.saveButton.enabled = (titleText.length > 0 && descriptionText.length > 0);
}
- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString* changedString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    [self enableSaveButtonForLocationDetail:self.titleField.text answer:changedString];
    return YES; //changes to text views need to check if the save should be disabled
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self.titleField resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
    
    //completion handler pass nil if cancel is pressed no change to stored data
    if (self.completionHandler) {
        self.completionHandler(nil,nil);
    }
    
    self.titleField.text = nil;
    self.descriptionTextView.text = nil;
}
- (IBAction)saveButtonTapped:(id)sender {
    [self.titleField resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
    
    //completion handler
    if (self.completionHandler) { //pass values if save is pressed 
        self.completionHandler(self.titleField.text, self.descriptionTextView.text);
    }
    
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
