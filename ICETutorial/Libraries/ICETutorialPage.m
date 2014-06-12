//
//  ICETutorialPage.m
//  ICETutorial
//
//  Created by Icepat Dev on 25/03/13.
//  Copyright (c) 2013 Patrick Trillsam. All rights reserved.
//

#import "ICETutorialPage.h"

@implementation ICETutorialLabelStyle

// Init.
- (id)initWithText:(NSString *)text {
    self = [super init];
    if (self){
        _text = text;
    }
    return self;
}

- (id)initWithText:(NSString *)text
              font:(UIFont *)font
         textColor:(UIColor *)color {
    self = [self initWithText:text];
    if (self){
        _font = font;
        _textColor = color;
    }
    return self;
}

@end

@implementation ICETutorialPage

// Init.
- (id)initWithTitle:(NSString *)title
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
