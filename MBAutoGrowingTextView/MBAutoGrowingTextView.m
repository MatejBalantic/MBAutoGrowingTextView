//
//  TINAutoGrowingTextView.m
//  TINUIKit
//
//  Created by Matej Balantic on 14/05/14.
//  Copyright (c) 2014 Matej Balantič. All rights reserved.
//

#import "MBAutoGrowingTextView.h"
#import "../../../../Tradesy/UIColor+Tradesy.h"

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

- (void)setHeight:(CGFloat)height {
    if(height <= self.maxHeightConstraint.constant) {
        self.heightConstraint.constant = height;
    }
}

- (void)setMinHeight:(CGFloat)minHeight {
    self.minHeightConstraint.constant = minHeight;
}

- (void)setMaxHeight:(CGFloat)maxHeight {
    self.maxHeightConstraint.constant = maxHeight;
}

// returns a height that will properly fit all text
- (CGFloat)suggestedHeightFrom:(CGFloat)height {
    
    // padding that does not include text
    CGFloat padding = (self.textContainerInset.top + self.textContainerInset.bottom);
    
    // height of actual text
    NSInteger processedHeight = height - padding;
    
    // amount that should be subtracted from height to correctly fit all lines
    NSInteger diff = processedHeight % (NSInteger)self.font.lineHeight;
    processedHeight -= diff;
    
    return processedHeight + padding;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    
    NSAssert(self.heightConstraint != nil, @"Unable to find height auto-layout constraint. MBAutoGrowingTextView\
             needs a Auto-layout environment to function. Make sure you are using Auto Layout and that UITextView is enclosed in\
             a view with valid auto-layout constraints.");
    
    // keep track if height is changing
    BOOL changed = NO;
    
    // calculate size needed for the text to be visible without scrolling
    float newHeight = self.intrinsicContentSize.height;
    
    // these are suggested min/max heights that will correctly fit each line of text
    CGFloat suggestedMinHeight = [self suggestedHeightFrom:self.minHeightConstraint.constant];
    CGFloat suggestedMaxHeight = [self suggestedHeightFrom:self.maxHeightConstraint.constant];
    
    // if there is any maximal height constraint set, make sure we consider that
    if (self.maxHeightConstraint) {
        newHeight = MIN(newHeight, suggestedMaxHeight);
    }

    // if there is any minimal height constraint set, make sure we consider that
    if (self.minHeightConstraint) {
        newHeight = MAX(newHeight, suggestedMinHeight);
    }
    
    // check if the height has changed
    changed = newHeight != self.heightConstraint.constant;
    
    if(changed) {
        self.heightConstraint.constant = newHeight;
        if(_autoGrowingTextViewDelegate) {
            CGSize newSize = self.intrinsicContentSize;
            newSize.height = newHeight;
            [_autoGrowingTextViewDelegate textView:self didChangeSize:newSize];
        }
    }
}

- (CGSize)intrinsicContentSize {
    
    // height should be text view content size
    CGSize intrinsicContentSize = self.contentSize;
    
    // increment size by textContainerInset
    intrinsicContentSize.width += (self.textContainerInset.left + self.textContainerInset.right) / 2.0f;
    intrinsicContentSize.height += (self.textContainerInset.top + self.textContainerInset.bottom);
    
    return intrinsicContentSize;
}

@end
