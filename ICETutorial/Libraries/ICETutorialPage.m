//
//  ICETutorialPage.m
//  ICETutorial
//
//  Created by Icepat Dev on 25/03/13.
//  Copyright (c) 2013 Patrick Trillsam. All rights reserved.
//

#import "ICETutorialPage.h"

@implementation ICETutorialLabelStyle
@synthesize font = _font;
@synthesize text = _text;
@synthesize textColor = _textColor;
@synthesize linesNumber = _linesNumber;
@synthesize offset = _offset;

// Init.
- (id)initWithText:(NSString *)text
{
    self = [super init];
    if (self){
        _text = text;
    }
    return self;
}

- (id)initWithText:(NSString *)text
              font:(UIFont *)font
         textColor:(UIColor *)color
{
    self = [self initWithText:text];
    if (self){
        _font = font;
        _textColor = color;
    }
    return self;
}

@end

@implementation ICETutorialPage
@synthesize subTitle = _subTitle;
@synthesize description = _description;
@synthesize pictureName = _pictureName;

// Init.
- (id)initWithSubTitle:(NSString *)subTitle
           description:(NSString *)description
           pictureName:(NSString *)pictureName{
    self = [super init];
    if (self){
        _subTitle = [[ICETutorialLabelStyle alloc] initWithText:subTitle];
        _description = [[ICETutorialLabelStyle alloc] initWithText:description];
        _pictureName = pictureName;
    }
    return self;
}

- (void)setSubTitleStyle:(ICETutorialLabelStyle *)style{
    [_subTitle setFont:style.font];
    [_subTitle setTextColor:style.textColor];
}

- (void)setDescription:(ICETutorialLabelStyle *)style{
    [_description setFont:style.font];
    [_description setTextColor:style.textColor];
}

@end
