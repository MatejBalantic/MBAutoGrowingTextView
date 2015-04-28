//
//  TINAutoGrowingTextView.h
//  TINUIKit
//
//  Created by Matej Balantic on 14/05/14.
//  Copyright (c) 2014 Matej Balantič. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * An auto-layout based light-weight UITextView subclass which automatically grows and shrinks
 based on the size of user input and can be constrained by maximal and minimal height - all without
 a single line of code.
 
 Made primarely for use in Interface builder and only works with Auto layout.
 
 Usage: subclass desired UITextView in IB and assign min-height and max-height constraints
 */

@protocol MBAutoGrowingTextViewDelegate;

@interface MBAutoGrowingTextView : UITextView

@property (nonatomic, assign) id<MBAutoGrowingTextViewDelegate> autoGrowingTextViewDelegate;

- (void)setHeight:(CGFloat)height;
- (void)setMinHeight:(CGFloat)minHeight;
- (void)setMaxHeight:(CGFloat)maxHeight;

@end

@protocol MBAutoGrowingTextViewDelegate <NSObject>

@required
- (void)textView:(MBAutoGrowingTextView *)textView didChangeSize:(CGSize)newSize;

@end
