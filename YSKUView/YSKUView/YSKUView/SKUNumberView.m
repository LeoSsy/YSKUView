//
//  SKUNumberView.m
//  YSKUView
//
//  Created by shusy on 2017/11/22.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "SKUNumberView.h"

#define kWhiteGrayColor [UIColor colorWithRed:209.0f/255.0f green:213.0f/255.0f blue:219.0f/255.0f alpha:1.0f]

@interface SKUNumberView() <UITextFieldDelegate>
@property (nonatomic, strong) UILabel   *hintLabel;
@property (nonatomic, strong) UIButton  *minusButton;
@property (nonatomic, strong) UIButton  *addButton;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation SKUNumberView {
    CGSize _contentSize;
    CGFloat _padding;
    CGFloat _fontSize;
}

@synthesize hintLabel = _hintLabel;
@synthesize minusButton = _minusButton;
@synthesize addButton = _addButton;
@synthesize textField = _textField;
@synthesize topLine = _topLine;
@synthesize bottomLine = _bottomLine;

- (id) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if (self) {
        _contentSize = frame.size;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _contentSize = CGSizeZero;
        [self commonInit];
    }
    return self;
}

- (void) commonInit {
    self.backgroundColor = [UIColor redColor];
    _padding = 10.0f;
    _fontSize = 18.0f;
    [self addSubview:self.hintLabel];
    [self addSubview:self.minusButton];
    [self addSubview:self.addButton];
    [self addSubview:self.textField];
    [self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
    
    self.minNumber = 1;
    self.maxNumber = NSUIntegerMax;
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark --
#pragma mark -- Action

- (void) enableButtonWithValue:(NSInteger) currentNumber {
    _addButton.enabled = (currentNumber < _maxNumber);
    _minusButton.enabled = (currentNumber > _minNumber);
}

- (void) setMaxNumber:(NSInteger)maxNumber {
    _maxNumber = maxNumber;
    NSInteger currentNumber = [self.textField.text integerValue];
    if (currentNumber > _maxNumber) {
        self.currentValue = currentNumber = _maxNumber;
    }
    [self enableButtonWithValue:currentNumber];
}

- (void) setMinNumber:(NSInteger)minNumber {
    _minNumber = minNumber;
    NSInteger currentNumber = [self.textField.text integerValue];
    if (currentNumber < _minNumber) {
        self.currentValue = currentNumber = _minNumber;
    }
    [self enableButtonWithValue:currentNumber];
}

- (void)minusButtonAction:(id)sender {
    NSInteger currentNumber = [self.textField.text integerValue];
    currentNumber--;
    if (currentNumber >= _minNumber) {
        self.currentValue = currentNumber;
    }
    //告诉代理数量改变
    if ([self.delegate respondsToSelector:@selector(numberDidChanged:)]) {
        [self.delegate numberDidChanged:currentNumber];
    }
    [self enableButtonWithValue:currentNumber];
}

- (void)addButtonAction:(id)sender {
    NSInteger currentNumber = [self.textField.text integerValue];
    currentNumber++;
    if (currentNumber <= _maxNumber) {
        self.currentValue = currentNumber;
    } else {
        currentNumber = _maxNumber;
    }
    //告诉代理数量改变
    if ([self.delegate respondsToSelector:@selector(numberDidChanged:)]) {
        [self.delegate numberDidChanged:currentNumber];
    }
    [self enableButtonWithValue:currentNumber];
}

- (void) setCurrentValue:(NSInteger)currentValue {
    NSInteger result = currentValue;
    if (result > _maxNumber || result < _minNumber) {
        result = _minNumber;
    }
    self.textField.text = [NSString stringWithFormat:@"%@", @(result)];
}

- (void)setShowHintLabel:(BOOL)showHintLabel {
    _showHintLabel = showHintLabel;
    if (showHintLabel) {
        _hintLabel.frame = CGRectMake(_padding,_padding,self.frame.size.width,20);
        _minusButton.frame = CGRectMake(_padding , CGRectGetMaxY(self.hintLabel.frame)+_padding, 40, 40);
        _textField.frame = CGRectMake(CGRectGetMaxX(self.minusButton.frame), self.minusButton.frame.origin.y, 50, 40);
        _topLine.frame = CGRectMake(self.textField.frame.origin.x, self.textField.frame.origin.y,  self.textField.frame.size.width, 0.8);
        _bottomLine.frame = CGRectMake(self.textField.frame.origin.x, CGRectGetMaxY(self.textField.frame)-0.8,  self.textField.frame.size.width, 0.8);
        _addButton.frame = CGRectMake(CGRectGetMaxX(self.textField.frame), self.minusButton.frame.origin.y, 40, 40);
    }else{
        _hintLabel.frame = CGRectZero;
        _minusButton.frame = CGRectMake(0 , 0, 40, 40);
        _textField.frame = CGRectMake(CGRectGetMaxX(self.minusButton.frame), self.minusButton.frame.origin.y, 50, 40);
        _topLine.frame = CGRectMake(self.textField.frame.origin.x, self.textField.frame.origin.y,  self.textField.frame.size.width, 0.8);
        _bottomLine.frame = CGRectMake(self.textField.frame.origin.x, CGRectGetMaxY(self.textField.frame)-0.8,  self.textField.frame.size.width, 0.8);
        _addButton.frame = CGRectMake(CGRectGetMaxX(self.textField.frame), self.minusButton.frame.origin.y, 40, 40);
    }
}

#pragma mark --
#pragma mark -- getter

- (UITextField *) inputTextField {
    return self.textField;
}

- (NSInteger) currentValue {
    NSInteger currentNumber = [self.textField.text integerValue];
    return currentNumber;
}

- (UILabel *) hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] initWithFrame:
                      CGRectMake(_padding,_padding,self.frame.size.width,20)];
        _hintLabel.backgroundColor = [UIColor clearColor];
        _hintLabel.font = [UIFont systemFontOfSize:_fontSize - 3];
        _hintLabel.text = @"购买数量";
    }
    return _hintLabel;
}

- (UIButton *) minusButton {
    if (!_minusButton) {
        _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _minusButton.frame = CGRectMake(_padding , CGRectGetMaxY(self.hintLabel.frame)+_padding, 40, 40);
        _minusButton.titleLabel.font = [UIFont boldSystemFontOfSize:_fontSize];
        [_minusButton setTitle:@"-" forState:UIControlStateNormal];
        [_minusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_minusButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_minusButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_minusButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _minusButton.layer.borderWidth = 1.0f;
        _minusButton.layer.borderColor = [kWhiteGrayColor CGColor];
        [_minusButton addTarget:self action:@selector(minusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusButton;
}

- (UITextField *) textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:
                      CGRectMake(CGRectGetMaxX(self.minusButton.frame), self.minusButton.frame.origin.y, 50, 40)];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.delegate = self;
        _textField.text = @"1";
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.font = [UIFont boldSystemFontOfSize:_fontSize];
    }
    return _textField;
}

- (UIView *) topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc] initWithFrame:
                    CGRectMake(self.textField.frame.origin.x, self.textField.frame.origin.y,  self.textField.frame.size.width, 0.8)];
        _topLine.backgroundColor = kWhiteGrayColor;
    }
    return _topLine;
}

- (UIView *) bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:
                       CGRectMake(self.textField.frame.origin.x, CGRectGetMaxY(self.textField.frame)-0.8,  self.textField.frame.size.width, 0.8)];
        _bottomLine.backgroundColor = kWhiteGrayColor;
    }
    return _bottomLine;
}

- (UIButton *) addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame =
        CGRectMake(CGRectGetMaxX(self.textField.frame), self.minusButton.frame.origin.y, 40, 40);
        _addButton.titleLabel.font = [UIFont boldSystemFontOfSize:_fontSize];
        [_addButton setTitle:@"+" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_addButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_addButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        _addButton.layer.borderWidth = 1.0f;
        _addButton.layer.borderColor = [kWhiteGrayColor CGColor];
        [_addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}


#pragma mark --
#pragma mark -- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        self.currentValue = _minNumber;
        //告诉代理数量改变
        if ([self.delegate respondsToSelector:@selector(numberDidChanged:)]) {
            [self.delegate numberDidChanged:self.currentValue];
        }
        [self enableButtonWithValue:self.currentValue];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *result = [NSMutableString stringWithString:textField.text];
    [result replaceCharactersInRange:range withString:string];
    if (result.length == 0) {
        return YES;
    }
    NSInteger currentNumber = [result integerValue];
    if (currentNumber <= _maxNumber && currentNumber >= _minNumber) {
        //告诉代理数量改变
        if ([self.delegate respondsToSelector:@selector(numberDidChanged:)]) {
            [self.delegate numberDidChanged:currentNumber];
        }
        [self enableButtonWithValue:currentNumber];
        return YES;
    }
    return NO;
}

@end

