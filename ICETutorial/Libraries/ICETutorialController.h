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
typedef enum {
    ScrollingStateAuto,
    ScrollingStateLooping,
    ScrollingStateManual
}ScrollingState;

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
}

@property (nonatomic, assign) BOOL autoScrollEnabled;
@property (nonatomic, assign) BOOL autoScrollLooping;
@property (nonatomic, assign) CGFloat autoScrollDurationOnPage;
@property (nonatomic, retain) ICETutorialLabelStyle *commonPageSubTitleStyle;
@property (nonatomic, retain) ICETutorialLabelStyle *commonPageDescriptionStyle;

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
             andPages:(NSArray *)pages;
- (void)startScrolling;

// Pages management.
- (void)setPages:(NSArray*)pages;
- (NSUInteger)numberOfPages;

// Actions.
- (IBAction)didClickOnButton1:(id)sender;
- (IBAction)didClickOnButton2:(id)sender;

@end
