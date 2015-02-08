//
//  SKInputView.m
//  SKInputViewExample
//
//  Created by zhaosk on 15/2/8.
//  Copyright (c) 2015年 zhaosk. All rights reserved.
//

#import "SKInputView.h"

@interface SKInputView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightNLC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendBtnBottomNLC;
@property (weak, nonatomic) IBOutlet UILabel *textPlaceholder;

@end

@implementation SKInputView

#pragma mark - Life circle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupViews];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupViews];
    }
    
    return self;
}

#pragma mark - Private methods

- (NSLayoutConstraint *)pin:(id)item attribute:(NSLayoutAttribute)attribute
{
    return [NSLayoutConstraint constraintWithItem:self
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:item
                                        attribute:attribute
                                       multiplier:1.0
                                         constant:0.0];
}

- (void)setupViews
{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[self pin:self.contentView attribute:NSLayoutAttributeTop]];
    [self addConstraint:[self pin:self.contentView attribute:NSLayoutAttributeLeft]];
    [self addConstraint:[self pin:self.contentView attribute:NSLayoutAttributeBottom]];
    [self addConstraint:[self pin:self.contentView attribute:NSLayoutAttributeRight]];
    
    //UI
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    self.textView.layer.cornerRadius = 5;
    
    //Adjust textView height.
    self.textViewHeightNLC.constant = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX)].height;
    [self adjustSendBtnPosition];
}

- (void)adjustSendBtnPosition
{
    CGFloat containerHeight = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.sendBtnBottomNLC.constant = (containerHeight - self.sendBtn.intrinsicContentSize.height) / 2;
}

- (void)setPlaceholder:(NSString *)plcaeholder
{
    _placeholder = plcaeholder;
    
    self.textPlaceholder.text = plcaeholder;
}

#pragma mark - User interactions
- (IBAction)onSend:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(inputViewDidPressSendButton:)])
    {
        [self.delegate inputViewDidPressSendButton:self];
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
    {
        return [self.delegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.sendBtn.enabled = self.textPlaceholder.hidden = textView.text.length ? YES : NO;
    
    if (self.textViewHeightNLC.constant != self.textView.contentSize.height)
    {
        CGFloat newHeight = self.textView.contentSize.height;
        if (self.textViewMaxHeight > 0.)
        {
            newHeight = MIN(self.textViewMaxHeight, self.textView.contentSize.height);
        }
        
        self.textViewHeightNLC.constant = newHeight;
        [self setNeedsUpdateConstraints];
    }
    
    if ([self.delegate respondsToSelector:@selector(textViewDidChange:)])
    {
        [self.delegate textViewDidChange:textView];
    }
}

@end