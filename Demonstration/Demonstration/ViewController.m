//
//  ViewController.m
//  Demonstration
//
//  Created by Matej Balantic on 16/05/14.
//  Copyright (c) 2014 Matej Balantič. All rights reserved.
//

#import "ViewController.h"
#import "MBAutoGrowingTextView.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet MBAutoGrowingTextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // show keyboard immediately after launch. Just for demonstrational
    // purpose, not required to use MBAutoGrowingTextView
    [self.textView becomeFirstResponder];
}

@end
