//
//  SKInputView.h
//  SKInputViewExample
//
//  Created by zhaosk on 15/2/8.
//  Copyright (c) 2015年 zhaosk. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SKInputViewDelegate;
@interface SKInputView : UIView
<
    UITextViewDelegate
>

@property (weak, nonatomic) id <SKInputViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@property (nonatomic) CGFloat textViewMaxHeight;
@property (nonatomic, copy) NSString *placeholder;

@end

@protocol SKInputViewDelegate <NSObject, UITextViewDelegate>

- (void)inputViewDidPressSendButton:(SKInputView *)inputView;

@end