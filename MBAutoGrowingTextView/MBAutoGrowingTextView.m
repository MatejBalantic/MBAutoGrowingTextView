//
//  TINAutoGrowingTextView.m
//  TINUIKit
//
//  Created by Matej Balantic on 14/05/14.
//  Copyright (c) 2014 Matej Balantič. All rights reserved.
//

#import "MBAutoGrowingTextView.h"

@interface MBAutoGrowingTextView ()
@property (nonatomic, weak) NSLayoutConstraint *heightConstraint;
@property (nonatomic, weak) NSLayoutConstraint *minHeightConstraint;
@property (nonatomic, weak) NSLayoutConstraint *maxHeightConstraint;
@end

@implementation MBAutoGrowingTextView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self associateConstraints];
    }
    
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self associateConstraints];
    }
    return self;
}

-(void)associateConstraints
{
    // iterate through all text view's constraints and identify
    // height, max height and min height constraints.
    
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            
            if (constraint.relation == NSLayoutRelationEqual) {
                self.heightConstraint = constraint;
            }
            
            else if (constraint.relation == NSLayoutRelationLessThanOrEqual) {
                self.maxHeightConstraint = constraint;
            }
            
            else if (constraint.relation == NSLayoutRelationGreaterThanOrEqual) {
                self.minHeightConstraint = constraint;
            }
        }
    }

}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    
    NSAssert(self.heightConstraint != nil, @"Unable to find height auto-layout constraint. MBAutoGrowingTextView\
             needs a Auto-layout environment to function. Make sure you are using Auto Layout and that UITextView is enclosed in\
             a view with valid auto-layout constraints.");
    
    // calculate size needed for the text to be visible without scrolling
    CGFloat newHeight;
    BOOL iOS7 = kCFCoreFoundationVersionNumber > kCFCoreFoundationVersionNumber_iOS_6_1;
    if (iOS7) {
        CGSize sizeThatFits = [self sizeThatFits:self.frame.size];
        newHeight = sizeThatFits.height;
    } else {
        newHeight = self.contentSize.height;
    }

    // if there is any minimal height constraint set, make sure we consider that
    if (self.maxHeightConstraint) {
        newHeight = MIN(newHeight, self.maxHeightConstraint.constant);
    }

    // if there is any maximal height constraint set, make sure we consider that
    if (self.minHeightConstraint) {
        newHeight = MAX(newHeight, self.minHeightConstraint.constant);
    }
    
    // update the height constraint
    self.heightConstraint.constant = newHeight;
}


@end
