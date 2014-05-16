//
//  MBViewController.m
//  MBAutoGrowingTextView
//
//  Created by Matej Balantic on 16/05/14.
//  Copyright (c) 2014 Matej Balantič. All rights reserved.
//

#import "MBViewController.h"
#import "MBAutoGrowingTextView.h"

@interface MBViewController ()
@property (nonatomic, weak) IBOutlet MBAutoGrowingTextView *textView;
@end

@implementation MBViewController

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // Open a keyboard immediately. This is placed here to simplify and focus the demo
    // Not needed in your own implementation
    [self.textView becomeFirstResponder];
}

@end
