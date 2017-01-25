//
//  InitialViewController.m
//  Grip
//
//  Created by luke anfang on 12/7/16.
//  Copyright © 2016 luke anfang. All rights reserved.

//lanfang@usc.edu

#import "InitialViewController.h"

@interface InitialViewController ()
@property (weak, nonatomic) IBOutlet UILabel *GripLabel;

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad]; //This is to do a fade in of the name of the app with alpha changes
    self.GripLabel.alpha = 0;
    [UIView animateWithDuration:2.0 animations:^{
        self.GripLabel.alpha = 1;
    }];
    // Do any additional setup after loading the view.
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

@end
