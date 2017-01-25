//
//  EditLocationDetailViewController.h
//  Grip
//
//  Created by luke anfang on 12/7/16.
//  Copyright © 2016 luke anfang. All rights reserved.
////lanfang@usc.edu

#import <UIKit/UIKit.h>

typedef void (^EditLocationDetailCompletionHandler)(NSString *title, NSString *description);
//edit completion handler :)
//The original title and description
@interface EditLocationDetailViewController : UIViewController
@property NSString *originalTitle;
@property NSString *originalDescription;
@property (copy, nonatomic) EditLocationDetailCompletionHandler completionHandler;
@end
