//
//  ICETutorialController.m
//  tutorial
//
//  Created by Patrick Trillsam on 25/03/13.
//  Copyright (c) 2013 Patrick Trillsam. All rights reserved.
//

#import "ICETutorialController.h"


@interface ICETutorialController ()

@end

@implementation ICETutorialController
@synthesize autoScrollEnabled = _autoScrollEnabled;
@synthesize autoScrollLooping = _autoScrollLooping;
@synthesize autoScrollDurationOnPage = _autoScrollDurationOnPage;
@synthesize commonPageSubTitleStyle = _commonPageSubTitleStyle;
@synthesize commonPageDescriptionStyle = _commonPageDescriptionStyle;

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        _autoScrollEnabled = YES;
        _autoScrollLooping = YES;
        _autoScrollDurationOnPage = TUTORIAL_DEFAULT_DURATION_ON_PAGE;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
             andPages:(NSArray *)pages{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        _pages = pages;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    windowSize_ = [[UIScreen mainScreen] bounds].size;
    
    // ScrollView configuration.
    [scrollView_ setContentSize:CGSizeMake([self numberOfPages] * windowSize_.width,
                                           scrollView_.contentSize.height)];
    [scrollView_ setPagingEnabled:YES];
    
    // PageControl configuration.
    [pageControl_ setNumberOfPages:[self numberOfPages]];
    [pageControl_ setCurrentPage:0];
    
    // Overlays.
    [self setOverlayTexts];
    
    // Preset the origin state.
    [self setOriginLayersState];

    // Run the auto-scrolling.
    [self autoScrollToNextPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions
- (IBAction)didClickOnButton1:(id)sender{
    
}

- (IBAction)didClickOnButton2:(id)sender{
    
}

#pragma mark - Pages
// Set the list of pages (ICETutorialPage)
- (void)setPages:(NSArray *)pages{
    _pages = pages;
}

- (NSUInteger)numberOfPages{
    if (_pages)
        return [_pages count];
    
    return 0;
}

#pragma mark - Animations
- (void)animateScrolling{
    if (currentState_ == ScrollingStateManual)
        return;
    
    // Jump to the next page...
    int nextPage = currentPageIndex_ + 1;
    if (nextPage == [self numberOfPages]){
        // ...stop the auto-scrolling or...
        if (!_autoScrollLooping){
            currentState_ = ScrollingStateManual;
            return;
        }
        
        // ...jump to the first page.
        nextPage = 0;
        currentState_ = ScrollingStateLooping;
        
        // Set alpha on layers.
        [self setLayersPrimaryAlphaWithPageIndex:0];
        [self setBackLayerPictureWithPageIndex:-1];
    } else {
        currentState_ = ScrollingStateAuto;
    }
    
    // Make the scrollView animation.
    [scrollView_ setContentOffset:CGPointMake(nextPage * windowSize_.width,0)
                         animated:YES];
    
    // Set the PageControl on the right page.
    [pageControl_ setCurrentPage:nextPage];
    
    // Call the next animation after X seconds.
    [self autoScrollToNextPage];
}

// Call the next animation after X seconds.
- (void)autoScrollToNextPage{
    if (_autoScrollEnabled)
        [self performSelector:@selector(animateScrolling)
                   withObject:nil
                   afterDelay:_autoScrollDurationOnPage];
}

- (void)startScrolling{
    [self autoScrollToNextPage];
}

#pragma mark - Overlay management
// Setup the Title Label.
- (void)setOverlayTitle{
    // ...or change by an UIImageView if you need it.
    [overlayTitle_ setText:@"Welcome"];
}

// Setup the SubTitle/Description style/text.
- (void)setOverlayTexts{
    int index = 0;    
    for(ICETutorialPage *page in _pages){
        // SubTitles.
        if ([[[page subTitle] text] length]){
            UILabel *subTitle = [self overlayLabelWithText:[[page subTitle] text]
                                                     layer:[page subTitle]
                                               commonStyle:_commonPageSubTitleStyle
                                                     index:index];
            [scrollView_ addSubview:subTitle];
        }
        // Description.
        if ([[[page description] text] length]){
            UILabel *description = [self overlayLabelWithText:[[page description] text]
                                                        layer:[page description]
                                                  commonStyle:_commonPageDescriptionStyle
                                                        index:index];
            [scrollView_ addSubview:description];
        }
        
        index++;
    }
}

- (UILabel *)overlayLabelWithText:(NSString *)text
                            layer:(ICETutorialLabelStyle *)style
                      commonStyle:(ICETutorialLabelStyle *)commonStyle
                            index:(NSUInteger)index{
    // SubTitles.
    UILabel *overlayLabel = [[UILabel alloc] initWithFrame:CGRectMake((index  * windowSize_.width),
                                                                      windowSize_.height - [commonStyle offset],
                                                                      windowSize_.width,
                                                                      TUTORIAL_LABEL_HEIGHT)];
    [overlayLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [overlayLabel setNumberOfLines:[commonStyle linesNumber]];
    [overlayLabel setBackgroundColor:[UIColor clearColor]];
    [overlayLabel setTextAlignment:NSTextAlignmentCenter];  

    // Datas and style.
    [overlayLabel setText:text];
    [style font] ? [overlayLabel setFont:[style font]] :
                   [overlayLabel setFont:[commonStyle font]];
    if ([style textColor])
        [overlayLabel setTextColor:[style textColor]];
    else
        [overlayLabel setTextColor:[commonStyle textColor]];
  
    [scrollView_ addSubview:overlayLabel];
    return overlayLabel;
}

#pragma mark - Layers management
// Handle the background layer image switch.
- (void)setBackLayerPictureWithPageIndex:(NSInteger)index{
    [self setBackgroundImage:backLayerView_ withIndex:index + 1];
}

// Handle the front layer image switch.
- (void)setFrontLayerPictureWithPageIndex:(NSInteger)index{
    [self setBackgroundImage:frontLayerView_ withIndex:index];
}

// Handle page image's loading
- (void)setBackgroundImage:(UIImageView *)imageView withIndex:(NSInteger)index{
    if (index >= [_pages count]){
        [imageView setImage:nil];
        return;
    }
    
    NSString *imageName = [NSString stringWithFormat:@"%@",[[_pages objectAtIndex:index] pictureName]];
    [imageView setImage:[UIImage imageNamed:imageName]];
}

// Setup layer's alpha.
- (void)setLayersPrimaryAlphaWithPageIndex:(NSInteger)index{
    [frontLayerView_ setAlpha:1];
    [backLayerView_ setAlpha:0];
}

// Preset the origin state.
- (void)setOriginLayersState{
    currentState_ = ScrollingStateAuto;
    [self setLayersPicturesWithIndex:0];
}

// Setup the layers with the page index.
- (void)setLayersPicturesWithIndex:(NSInteger)index{
    currentPageIndex_ = index;
    [self setLayersPrimaryAlphaWithPageIndex:index];
    [self setFrontLayerPictureWithPageIndex:index];
    [self setBackLayerPictureWithPageIndex:index];
}

// Animate the fade-in/out (Cross-disolve) with the scrollView translation.
- (void)disolveBackgroundWithContentOffset:(float)offset{
    if (currentState_ == ScrollingStateLooping){
        // Jump from the last page to the first.
        [self scrollingToFirstPageWithOffset:offset];
    } else {
        // Or just scroll to the next/previous page.
        [self scrollingToNextPageWithOffset:offset];
    }
}

// Handle alpha on layers when the auto-scrolling is looping to the first page.
- (void)scrollingToFirstPageWithOffset:(float)offset{
    // Compute the scrolling percentage on all the page.
    offset = (offset * windowSize_.width) / (windowSize_.width * [self numberOfPages]);
    
    // Scrolling finished...
    if (offset == 0){
        // ...reset to the origin state.
        [self setOriginLayersState];
        return;
    }
    
    // Invert alpha for the back picture.
    float backLayerAlpha = (1 - offset);
    float frontLayerAlpha = offset;
    
    // Set alpha.
    [backLayerView_ setAlpha:backLayerAlpha];
    [frontLayerView_ setAlpha:frontLayerAlpha];
}

// Handle alpha on layers when we are scrolling to the next/previous page.
- (void)scrollingToNextPageWithOffset:(float)offset{
    // Current page index in scrolling.
    NSInteger page = (int)(offset);
    
    // Keep only the float value.
    float alphaValue = offset - (int)offset;
    
    // This is only when you scroll to the right on the first page.
    // That will fade-in black the first picture.
    if (alphaValue < 0 && currentPageIndex_ == 0){
        [backLayerView_ setImage:nil];
        [frontLayerView_ setAlpha:(1 + alphaValue)];
        return;
    }
    
    // Switch pictures, and imageView alpha.
    if (page != currentPageIndex_)
        [self setLayersPicturesWithIndex:page];
    
    // Invert alpha for the front picture.
    float backLayerAlpha = alphaValue;
    float frontLayerAlpha = (1 - alphaValue);
    
    // Set alpha.
    [backLayerView_ setAlpha:backLayerAlpha];
    [frontLayerView_ setAlpha:frontLayerAlpha];
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // Get scrolling position, and send the alpha values.
    float scrollingPosition = scrollView.contentOffset.x / windowSize_.width;
    [self disolveBackgroundWithContentOffset:scrollingPosition];
    
    if (scrollView_.isTracking)
        currentState_ = ScrollingStateManual;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // Update the page index.
    [pageControl_ setCurrentPage:currentPageIndex_];
}

@end
