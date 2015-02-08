//
//  ViewController.m
//  SKInputViewExample
//
//  Created by zhaosk on 15/2/8.
//  Copyright (c) 2015年 zhaosk. All rights reserved.
//

#import "ViewController.h"
#import "SKInputView.h"

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SKInputView *inputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomNLC;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.inputView.textViewMaxHeight = 75;
    self.inputView.placeholder = @"想说的话...";
    [self.inputView.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    
    [self installKeyboardNotifications];
}

- (void)dealloc
{
    [self removeKeyboardNotifications];
}

#pragma mark - User interactions
- (IBAction)onTapBg:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark - Keyboard
- (void)keyboardWillToggle:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.bottomNLC.constant = (SCREEN_HEIGHT - endFrame.origin.y);
    [UIView animateWithDuration:duration
                          delay:0
                        options:(animationCurve << 16)|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.view setNeedsUpdateConstraints];
                         [self.view layoutIfNeeded];
                     }
                     completion:NULL];
}

- (void)installKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillToggle:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillToggle:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

@end
