//
//  NPKeyboardLayoutGuide.m
//
//  Created by Oleksii Kuchma on 9/13/14.
//
//  Copyright (c) 2014 Oleksii Kuchma <nod3pad@gmail.com>
//

#import "NPKeyboardLayoutGuide.h"

#import <objc/runtime.h>

@interface NPKeyboardLayoutGuide : UIView

@property (nonatomic, weak) NSLayoutConstraint *verticalPositionConstraint;

/**
 Add layout guide to view
 
 @param view View to which layout guide should be added.
 */
- (void)addToView:(UIView *)view;

@end

@implementation UIViewController (NPKeyboardLayoutGuide)

- (id)keyboardLayoutGuide
{
    NPKeyboardLayoutGuide *layoutGuide = objc_getAssociatedObject(self, "NPKeyboardLayoutGuide");
    
    if (!layoutGuide)
    {
        layoutGuide = [[NPKeyboardLayoutGuide alloc] init];
        [layoutGuide addToView:self.view];
        
        objc_setAssociatedObject(self, "NPKeyboardLayoutGuide", layoutGuide, OBJC_ASSOCIATION_ASSIGN);
    }
    
    return layoutGuide;
}

@end

@implementation NPKeyboardLayoutGuide

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addToView:(UIView *)view
{
    NSAssert((self.superview == nil), @"Keyboard layout guide has already added to view!");
    
    self.hidden = YES;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addSubview:self];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:view
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.f
                                                                   constant:0.f];
    
    [view addConstraint:constraint];
    
    self.verticalPositionConstraint = constraint;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationCurveOptions = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    
    CGRect endKeyboardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect windowFrame = self.window.frame;
    
    CGRect convertedEndFrame = [self.window convertRect:endKeyboardFrame toView:self.superview];
    CGRect convertedWindowFrame = [self.window convertRect:windowFrame toView:self.superview];
    
    CGFloat convertedEndKeyboardHeight = CGRectGetHeight(convertedEndFrame);
    CGFloat convertedWindowBottomOffset = CGRectGetMaxY(convertedWindowFrame) - CGRectGetMaxY(self.superview.bounds);
    
    BOOL keyboardIsVisible = CGRectGetMinY(endKeyboardFrame) < CGRectGetMaxY(windowFrame);
    
    BOOL needSetVerticalPositionConstraintConstant = keyboardIsVisible && ABS(convertedWindowBottomOffset) < convertedEndKeyboardHeight;
    
    _verticalPositionConstraint.constant = needSetVerticalPositionConstraintConstant ? - (convertedEndKeyboardHeight - convertedWindowBottomOffset) : 0.f;
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | animationCurveOptions
                     animations:^
     {
         [self.superview layoutIfNeeded];
     }
                     completion:nil];
}

@end
