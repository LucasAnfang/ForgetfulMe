//
//  AddLocationDetailViewController.h
//  Grip
//
//  Created by luke anfang on 12/6/16.
//  Copyright © 2016 luke anfang. All rights reserved.
////lanfang@usc.edu

#import <UIKit/UIKit.h>
//completion handler
typedef void (^AddLocationDetailCompletionHandler)(NSString *title, NSString *description);

@interface AddLocationDetailViewController : UIViewController

@property (copy, nonatomic) AddLocationDetailCompletionHandler completionHandler;
@end
