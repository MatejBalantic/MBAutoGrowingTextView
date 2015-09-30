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

//#define DEMONSTRATE_INIT_FROM_CODE 1

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

#ifdef DEMONSTRATE_INIT_FROM_CODE
    
    self.textView.hidden = YES;
    
    // init from code and add to the view
    MBAutoGrowingTextView* programmaticalTextView = [[MBAutoGrowingTextView alloc]init];
    programmaticalTextView.backgroundColor = self.textView.backgroundColor;
    [self.view addSubview:programmaticalTextView];
    
    // configure Autolayout
    programmaticalTextView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint* bottomConstraint = [NSLayoutConstraint constraintWithItem:programmaticalTextView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-215];
    NSLayoutConstraint* leadingConstraint = [NSLayoutConstraint constraintWithItem:programmaticalTextView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint* trailingConstraint = [NSLayoutConstraint constraintWithItem:programmaticalTextView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:programmaticalTextView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:33];
    NSLayoutConstraint* maxHeightConstraint = [NSLayoutConstraint constraintWithItem:programmaticalTextView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100];
    NSLayoutConstraint* minHeightConstraint = [NSLayoutConstraint constraintWithItem:programmaticalTextView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:heightConstraint.constant];
    
    [programmaticalTextView addConstraints:@[heightConstraint, maxHeightConstraint, minHeightConstraint]];
    [self.view addConstraints:@[bottomConstraint, leadingConstraint, trailingConstraint]];
    
    [programmaticalTextView becomeFirstResponder];
    
#else
    
    // show keyboard immediately after launch. Just for demonstrational
    // purpose, not required to use MBAutoGrowingTextView
    [self.textView becomeFirstResponder];
    
#endif
}

@end
