//
//  ICETutorialPage.m
//  ICETutorial
//
//  Created by Patrick Trillsam on 25/03/13.
//  Copyright (c) 2014 https://github.com/icepat/ICETutorial. All rights reserved.
//

#import "ICETutorialPage.h"

@implementation ICETutorialLabelStyle

// Init.
- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self){
        _text = text;
    }
    return self;
}

- (instancetype)initWithFont:(UIFont *)font
                   textColor:(UIColor *)color
                 linesNumber:(NSUInteger)linesNumber
                      offset:(NSUInteger)offset {
    self = [self init];
    if (self){
        _font = font;
        _textColor = color;
        _linesNumber = linesNumber;
        _offset = offset;
    }
    return self;
}

@end

@implementation ICETutorialPage

// Init.
- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                  pictureName:(NSString *)pictureName
                     duration:(NSTimeInterval)duration {
    self = [super init];
    if (self){
        _title = [[ICETutorialLabelStyle alloc] initWithText:title];
        _subTitle = [[ICETutorialLabelStyle alloc] initWithText:subTitle];
        _pictureName = pictureName;
        _duration = duration;
    }
    return self;
}

- (void)setTitleStyle:(ICETutorialLabelStyle *)style {
    [self.title setFont:style.font];
    [self.title setTextColor:style.textColor];
}

- (void)setSubTitleStyle:(ICETutorialLabelStyle *)style {
    [self.subTitle setFont:style.font];
    [self.subTitle setTextColor:style.textColor];
}

@end
