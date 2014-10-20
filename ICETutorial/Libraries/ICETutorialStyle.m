//
//  ICETutorialStyle.m
//  ICETutorial
//
//  Created by Patrick Trillsam on 25/03/13.
//  Copyright (c) 2014 https://github.com/icepat/ICETutorial. All rights reserved.
//

#import "ICETutorialStyle.h"
#import "ICETutorialController.h"

@implementation ICETutorialStyle

+ (instancetype)sharedInstance {
    static ICETutorialStyle *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ICETutorialStyle alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Properties
- (UIFont *)titleFont {
    if (_titleFont) {
        return _titleFont;
    }
    return TUTORIAL_TITLE_FONT;
}

- (UIColor *)titleColor {
    if (_titleColor) {
        return _titleColor;
    }
    return TUTORIAL_LABEL_TEXT_COLOR;
}

- (NSUInteger)titleLinesNumber {
    if (_titleLinesNumber != NSNotFound) {
        return _titleLinesNumber;
    }
    return TUTORIAL_TITLE_LINES_NUMBER;
}

- (NSUInteger)titleOffset {
    if (_titleOffset != NSNotFound) {
        return _titleOffset;
    }
    return TUTORIAL_TITLE_OFFSET;
}

- (UIFont *)subTitleFont {
    if (_subTitleFont) {
        return _subTitleFont;
    }
    return TUTORIAL_SUB_TITLE_FONT;
}

- (UIColor *)subTitleColor {
    if (_subTitleColor) {
        return _subTitleColor;
    }
    return TUTORIAL_LABEL_TEXT_COLOR;
}

- (NSUInteger)subTitleLinesNumber {
    if (_titleLinesNumber != NSNotFound) {
        return _titleLinesNumber;
    }
    return TUTORIAL_SUB_TITLE_LINES_NUMBER;
}

- (NSUInteger)subTitleOffset {
    if (_subTitleOffset != NSNotFound) {
        return _subTitleOffset;
    }
    return TUTORIAL_SUB_TITLE_OFFSET;
}

#pragma mark - Styles
- (ICETutorialLabelStyle *)titleStyle {
    if (_titleStyle) {
        return _titleStyle;
    }
    
    return [[ICETutorialLabelStyle alloc] initWithFont:self.titleFont
                                             textColor:self.titleColor
                                           linesNumber:self.titleLinesNumber
                                                offset:self.titleOffset];
}

- (ICETutorialLabelStyle *)subTitleStyle {
    if (_subTitleStyle) {
        return _subTitleStyle;
    }
    
    return [[ICETutorialLabelStyle alloc] initWithFont:self.subTitleFont
                                             textColor:self.subTitleColor
                                           linesNumber:self.subTitleLinesNumber
                                                offset:self.subTitleOffset];
}

@end
