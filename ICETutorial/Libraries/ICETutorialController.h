//
//  ICETutorialController.h
//
//
//  Created by Patrick Trillsam on 25/03/13.
//  Copyright (c) 2013 Patrick Trillsam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICETutorialPage.h"

#define TUTORIAL_LABEL_TEXT_COLOR               [UIColor whiteColor]
#define TUTORIAL_LABEL_HEIGHT                   34
#define TUTORIAL_SUB_TITLE_FONT                 [UIFont fontWithName:@"Helvetica-Bold" size:17.0f]
#define TUTORIAL_SUB_TITLE_LINES_NUMBER         1
#define TUTORIAL_SUB_TITLE_OFFSET               180
#define TUTORIAL_DESC_FONT                      [UIFont fontWithName:@"Helvetica" size:15.0f]
#define TUTORIAL_DESC_LINES_NUMBER              2
#define TUTORIAL_DESC_OFFSET                    150
#define TUTORIAL_DEFAULT_DURATION_ON_PAGE       3.0f

// Scrolling state.
typedef NS_OPTIONS(NSUInteger, ScrollingState) {
    ScrollingStateAuto      = 1 << 0,
    ScrollingStateManual    = 1 << 1,
    ScrollingStateLooping   = 1 << 2,
};

typedef void (^ButtonBlock)(UIButton *button);

@interface ICETutorialController : UIViewController <UIScrollViewDelegate> {
    __weak IBOutlet UIImageView *_backLayerView;
    __weak IBOutlet UIImageView *_frontLayerView;
    __weak IBOutlet UILabel *_overlayTitle;
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UIPageControl *_pageControl;
    
    CGSize _windowSize;
    ScrollingState _currentState;
    
    NSArray *_pages;
    int _currentPageIndex;
    
    BOOL _autoScrollEnabled;
    BOOL _autoScrollLooping;
    CGFloat _autoScrollDurationOnPage;
    
    ICETutorialLabelStyle *_commonPageSubTitleStyle;
    ICETutorialLabelStyle *_commonPageDescriptionStyle;
    
    ButtonBlock _button1Block;
    ButtonBlock _button2Block;
}

@property (nonatomic, assign) BOOL autoScrollEnabled;
@property (nonatomic, assign) BOOL autoScrollLooping;
@property (nonatomic, assign) CGFloat autoScrollDurationOnPage;
@property (nonatomic, retain) ICETutorialLabelStyle *commonPageSubTitleStyle;
@property (nonatomic, retain) ICETutorialLabelStyle *commonPageDescriptionStyle;

// Inits.
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
             andPages:(NSArray *)pages;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                pages:(NSArray *)pages
         button1Block:(ButtonBlock)block1
         button2Block:(ButtonBlock)block2;

// Actions.
- (void)setButton1Block:(ButtonBlock)block;
- (void)setButton2Block:(ButtonBlock)block;

// Pages management.
- (void)setPages:(NSArray*)pages;
- (NSUInteger)numberOfPages;

// Scrolling.
- (void)startScrolling;
- (void)stopScrolling;

// State.
- (ScrollingState)getCurrentState;

@end
