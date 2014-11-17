//
//  ICETutorialStyle.h
//  ICETutorial
//
//  Created by Patrick Trillsam on 25/03/13.
//  Copyright (c) 2014 https://github.com/icepat/ICETutorial. All rights reserved.
//

@import Foundation;
#import "ICETutorialPage.h"

@interface ICETutorialStyle : NSObject

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) NSUInteger titleLinesNumber;
@property (nonatomic, assign) NSUInteger titleOffset;
@property (nonatomic, strong) UIFont *subTitleFont;
@property (nonatomic, strong) UIColor *subTitleColor;
@property (nonatomic, assign) NSUInteger subTitleLinesNumber;
@property (nonatomic, assign) NSUInteger subTitleOffset;

@property (nonatomic, strong) ICETutorialLabelStyle *titleStyle;
@property (nonatomic, strong) ICETutorialLabelStyle *subTitleStyle;

+ (instancetype)sharedInstance;

@end
