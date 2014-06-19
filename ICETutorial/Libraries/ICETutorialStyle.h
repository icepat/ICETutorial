//
//  ICETutorialStyle.h
//  ICETutorial
//
//  Created by Patrick on 6/19/14.
//  Copyright (c) 2014 Patrick Trillsam. All rights reserved.
//

#import <Foundation/Foundation.h>
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
