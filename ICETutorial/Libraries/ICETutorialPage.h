//
//  ICETutorialPage.h
//  ICETutorial
//
//  Created by Icepat Dev on 25/03/13.
//  Copyright (c) 2013 Patrick Trillsam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICETutorialLabelStyle : NSObject

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, assign) NSUInteger linesNumber;
@property (nonatomic, assign) NSUInteger offset;

// Init.
- (id)initWithText:(NSString *)text;
- (id)initWithText:(NSString *)text
              font:(UIFont *)font
         textColor:(UIColor *)color;
@end

@interface ICETutorialPage : NSObject

@property (nonatomic, retain) ICETutorialLabelStyle *title;
@property (nonatomic, retain) ICETutorialLabelStyle *subTitle;
@property (nonatomic, retain) NSString *pictureName;
@property (nonatomic, assign) NSTimeInterval duration;

// Init.
- (id)initWithTitle:(NSString *)title
           subTitle:(NSString *)subTitle
        pictureName:(NSString *)pictureName
           duration:(NSTimeInterval)duration;

- (void)setTitleStyle:(ICETutorialLabelStyle *)style;
- (void)setSubTitleStyle:(ICETutorialLabelStyle *)style;

@end

