//
//  ICETutorialPage.h
//  ICETutorial
//
//  Created by Patrick Trillsam on 25/03/13.
//  Copyright (c) 2014 https://github.com/icepat/ICETutorial. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface ICETutorialLabelStyle : NSObject

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, assign) NSUInteger linesNumber;
@property (nonatomic, assign) NSUInteger offset;

// Init.
- (instancetype)initWithText:(NSString *)text;
- (instancetype)initWithFont:(UIFont *)font
                   textColor:(UIColor *)color
                 linesNumber:(NSUInteger)linesNumber
                      offset:(NSUInteger)offset;
@end

@interface ICETutorialPage : NSObject

@property (nonatomic, retain) ICETutorialLabelStyle *title;
@property (nonatomic, retain) ICETutorialLabelStyle *subTitle;
@property (nonatomic, retain) NSString *pictureName;
@property (nonatomic, assign) NSTimeInterval duration;

// Init.
- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                  pictureName:(NSString *)pictureName
                     duration:(NSTimeInterval)duration;

- (void)setTitleStyle:(ICETutorialLabelStyle *)style;
- (void)setSubTitleStyle:(ICETutorialLabelStyle *)style;

@end

