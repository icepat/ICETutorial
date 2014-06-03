//
//  ICETutorialController.m
//
//
//  Created by Patrick Trillsam on 25/03/13.
//  Copyright (c) 2013 Patrick Trillsam. All rights reserved.
//

#import "ICETutorialController.h"


@interface ICETutorialController ()
@property (nonatomic, strong, readonly) UIImageView *frontLayerView;
@property (nonatomic, strong, readonly) UIImageView *backLayerView;
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) UILabel *overlayTitle;
@property (nonatomic, strong, readonly) UIPageControl *pageControl;
@property (nonatomic, strong, readonly) UIButton *leftButton;
@property (nonatomic, strong, readonly) UIButton *rightButton;
@end

@implementation ICETutorialController

- (instancetype)initWithPages:(NSArray *)pages {
    self = [self init];
    if (self) {
        _autoScrollEnabled = YES;
        _autoScrollLooping = YES;
        _autoScrollDurationOnPage = TUTORIAL_DEFAULT_DURATION_ON_PAGE;
        _pages = pages;
    }
    return self;
}

- (instancetype)initWithPages:(NSArray *)pages
                 button1Block:(ButtonBlock)block1
                 button2Block:(ButtonBlock)block2 {
    self = [self initWithPages:pages];
    if (self) {
        _button1Block = block1;
        _button2Block = block2;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    _windowSize = [[UIScreen mainScreen] bounds].size;
    
    [self setupView];
    
    // Overlays.
    [self setOverlayTexts];
    [self setOverlayTitle];
    
    // Preset the origin state.
    [self setOriginLayersState];

    // Run the auto-scrolling.
    [self autoScrollToNextPage];
}

- (void)setupView {
    _frontLayerView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _backLayerView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    // Decoration.
    UIImageView *gradientView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 368, 320, 200)];
    [gradientView setImage:[UIImage imageNamed:@"background-gradient.png"]];
    
    // Title.
    _overlayTitle = [[UILabel alloc] initWithFrame:CGRectMake(84, 116, 212, 50)];
    [self.overlayTitle setTextColor:[UIColor whiteColor]];
    [self.overlayTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:32.0]];
    
    // ScrollView configuration.
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.scrollView setDelegate:self];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake([self numberOfPages] * _windowSize.width,
                                                self.scrollView.contentSize.height)];

    // PageControl configuration.
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(141, 453, 36, 32)];
    [self.pageControl setNumberOfPages:[self numberOfPages]];
    [self.pageControl setCurrentPage:0];
    [self.pageControl addTarget:self
                         action:@selector(didClickOnPageControl:)
               forControlEvents:UIControlEventValueChanged];
    
    // UIButtons.
    _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 494, 130, 36)];
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(172, 494, 130, 36)];
    [self.leftButton setBackgroundColor:[UIColor darkGrayColor]];
    [self.rightButton setBackgroundColor:[UIColor darkGrayColor]];
    [self.leftButton setTitle:@"Button 1" forState:UIControlStateNormal];
    [self.rightButton setTitle:@"Button 2" forState:UIControlStateNormal];
    
    [self.leftButton addTarget:self
                        action:@selector(didClickOnButton1:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self
                         action:@selector(didClickOnButton2:)
               forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:self.frontLayerView];
    [self.view addSubview:self.backLayerView];
    [self.view addSubview:gradientView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.overlayTitle];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.rightButton];
    
    [self addAllConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Constraints management.
- (void)addAllConstraints {
    [self imageViewConstraints];
    [self addSlugLineConstraints];
    [self addDateLineConstraints];
}

// UIImageView constraints.
- (void)imageViewConstraints {
	[self.frontLayerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
	[self.backLayerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.leftButton
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.rightButton
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.leftButton
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1
                                                           constant:20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.rightButton
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1
                                                           constant:20]];
    
    
    
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"H:|-20-[_leftButton(130)]-20-[_rightButton(130)]-20-|"
//                               options:0 metrics:nil
//                               views:NSDictionaryOfVariableBindings(_leftButton, _rightButton)]];
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"V:|-20-[_leftButton(36)]-|"
//                               options:0 metrics:nil
//                               views:NSDictionaryOfVariableBindings(_leftButton, _rightButton)]];
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"V:|-[_rightButton(36)]-20-|"
//                               options:0 metrics:nil
//                               views:NSDictionaryOfVariableBindings(_leftButton, _rightButton)]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.leftButton
//                                                     attribute:NSLayoutAttributeBottom
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:self.view
//                                                     attribute:NSLayoutAttributeBottom
//                                                    multiplier:1
//                                                      constant:20]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.leftButton
//                                                          attribute:NSLayoutAttributeLeft
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.view
//                                                          attribute:NSLayoutAttributeLeft
//                                                         multiplier:1
//                                                           constant:20]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.frontLayerView
//                                                     attribute:NSLayoutAttributeLeft
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:self
//                                                     attribute:NSLayoutAttributeLeft
//                                                    multiplier:1
//                                                      constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.frontLayerView
//                                                     attribute:NSLayoutAttributeRight
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:self
//                                                     attribute:NSLayoutAttributeRight
//                                                    multiplier:1
//                                                      constant:0]];
}

// Slug line constraints.
- (void)addSlugLineConstraints
{
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:_itemSlugLine
//                                                     attribute:NSLayoutAttributeTop
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:_itemHeadLine
//                                                     attribute:NSLayoutAttributeBottom
//                                                    multiplier:1
//                                                      constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:_itemSlugLine
//                                                     attribute:NSLayoutAttributeLeft
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:self
//                                                     attribute:NSLayoutAttributeLeft
//                                                    multiplier:1
//                                                      constant:CELL_CONTENT_PADDING]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:_itemSlugLine
//                                                     attribute:NSLayoutAttributeRight
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:self
//                                                     attribute:NSLayoutAttributeRight
//                                                    multiplier:1
//                                                      constant:-CELL_CONTENT_PADDING]];
}

// Date line constraints.
- (void)addDateLineConstraints
{
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:_itemDateLine
//                                                     attribute:NSLayoutAttributeTop
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:_itemSlugLine
//                                                     attribute:NSLayoutAttributeBottom
//                                                    multiplier:1
//                                                      constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:_itemDateLine
//                                                     attribute:NSLayoutAttributeLeft
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:self
//                                                     attribute:NSLayoutAttributeLeft
//                                                    multiplier:1
//                                                      constant:CELL_CONTENT_PADDING]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:_itemDateLine
//                                                     attribute:NSLayoutAttributeRight
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:self
//                                                     attribute:NSLayoutAttributeRight
//                                                    multiplier:1
//                                                      constant:-CELL_CONTENT_PADDING]];
}

#pragma mark - Actions
- (void)setButton1Block:(ButtonBlock)block {
    _button1Block = block;
}

- (void)setButton2Block:(ButtonBlock)block {
    _button2Block = block;
}

- (IBAction)didClickOnButton1:(id)sender {
    if (_button1Block)
        _button1Block(sender);
}

- (IBAction)didClickOnButton2:(id)sender {
    if (_button2Block)
        _button2Block(sender);
}

- (IBAction)didClickOnPageControl:(UIPageControl *)sender {
    _currentState = ScrollingStateManual;
    
    // Make the scrollView animation.
    [self.scrollView setContentOffset:CGPointMake(sender.currentPage * _windowSize.width,0)
                             animated:YES];
    
    // Set the PageControl on the right page.
    [_pageControl setCurrentPage:sender.currentPage];
}

#pragma mark - Pages
// Set the list of pages (ICETutorialPage).
- (void)setPages:(NSArray *)pages {
    _pages = pages;
}

- (NSUInteger)numberOfPages {
    if (_pages) {
        return [_pages count];
    }
    
    return 0;
}

#pragma mark - Animations
- (void)animateScrolling {
    if (_currentState & ScrollingStateManual) {
        return;
    }
    
    // Jump to the next page...
    NSInteger nextPage = _currentPageIndex + 1;
    if (nextPage == [self numberOfPages]) {
        // ...stop the auto-scrolling or...
        if (!_autoScrollLooping) {
            _currentState = ScrollingStateManual;
            return;
        }
        
        // ...jump to the first page.
        nextPage = 0;
        _currentState = ScrollingStateLooping;
        
        // Set alpha on layers.
        [self setLayersPrimaryAlphaWithPageIndex:0];
        [self setBackLayerPictureWithPageIndex:-1];
    } else {
        _currentState = ScrollingStateAuto;
    }
    
    // Make the scrollView animation.
    [self.scrollView setContentOffset:CGPointMake(nextPage * _windowSize.width,0)
                             animated:YES];
    
    // Set the PageControl on the right page.
    [self.pageControl setCurrentPage:nextPage];
    
    // Call the next animation after X seconds.
    [self autoScrollToNextPage];
}

// Call the next animation after X seconds.
- (void)autoScrollToNextPage {
    if (_autoScrollEnabled) {
        [self performSelector:@selector(animateScrolling)
                   withObject:nil
                   afterDelay:_autoScrollDurationOnPage];
    }
}

#pragma mark - Scrolling management
// Run it.
- (void)startScrolling {
    [self autoScrollToNextPage];
}

// Manually stop the scrolling
- (void)stopScrolling {
    _currentState = ScrollingStateManual;
}

#pragma mark - State management
// State.
- (ScrollingState)getCurrentState {
    return _currentState;
}

#pragma mark - Overlay management
// Setup the Title Label.
- (void)setOverlayTitle {
    // ...or change by an UIImageView if you need it.
    [self.overlayTitle setText:@"Welcome"];
}

// Setup the SubTitle/Description style/text.
- (void)setOverlayTexts {
    int index = 0;    
    for (ICETutorialPage *page in _pages) {
        // SubTitles.
        if ([[[page subTitle] text] length]) {
            UILabel *subTitle = [self overlayLabelWithText:[[page subTitle] text]
                                                     layer:[page subTitle]
                                               commonStyle:_commonPageSubTitleStyle
                                                     index:index];
            [self.scrollView addSubview:subTitle];
        }
        // Description.
        if ([[[page description] text] length]) {
            UILabel *description = [self overlayLabelWithText:[[page description] text]
                                                        layer:[page description]
                                                  commonStyle:_commonPageDescriptionStyle
                                                        index:index];
            [self.scrollView addSubview:description];
        }
        
        index++;
    }
}

- (UILabel *)overlayLabelWithText:(NSString *)text
                            layer:(ICETutorialLabelStyle *)style
                      commonStyle:(ICETutorialLabelStyle *)commonStyle
                            index:(NSUInteger)index {
    // SubTitles.
    UILabel *overlayLabel = [[UILabel alloc] initWithFrame:CGRectMake((index  * _windowSize.width),
                                                                      _windowSize.height - [commonStyle offset],
                                                                      _windowSize.width,
                                                                      TUTORIAL_LABEL_HEIGHT)];
    [overlayLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [overlayLabel setNumberOfLines:[commonStyle linesNumber]];
    [overlayLabel setBackgroundColor:[UIColor clearColor]];
    [overlayLabel setTextAlignment:NSTextAlignmentCenter];  

    // Datas and style.
    [overlayLabel setText:text];
    [style font] ? [overlayLabel setFont:[style font]] :
                   [overlayLabel setFont:[commonStyle font]];
    if ([style textColor]) {
        [overlayLabel setTextColor:[style textColor]];
    } else {
        [overlayLabel setTextColor:[commonStyle textColor]];
    }
  
    return overlayLabel;
}

#pragma mark - Layers management
// Handle the background layer image switch.
- (void)setBackLayerPictureWithPageIndex:(NSInteger)index {
    [self setBackgroundImage:self.backLayerView withIndex:index + 1];
}

// Handle the front layer image switch.
- (void)setFrontLayerPictureWithPageIndex:(NSInteger)index {
    [self setBackgroundImage:self.frontLayerView withIndex:index];
}

// Handle page image's loading
- (void)setBackgroundImage:(UIImageView *)imageView withIndex:(NSInteger)index {
    if (index >= [_pages count]) {
        [imageView setImage:nil];
        return;
    } 
    
    NSString *imageName = [NSString stringWithFormat:@"%@",[[_pages objectAtIndex:index] pictureName]];
    [imageView setImage:[UIImage imageNamed:imageName]];
}

// Setup layer's alpha.
- (void)setLayersPrimaryAlphaWithPageIndex:(NSInteger)index {
    [self.frontLayerView setAlpha:1];
    [self.backLayerView setAlpha:0];
}

// Preset the origin state.
- (void)setOriginLayersState {
    _currentState = ScrollingStateAuto;
    [self.backLayerView setBackgroundColor:[UIColor blackColor]];
    [self.frontLayerView setBackgroundColor:[UIColor blackColor]];
    [self setLayersPicturesWithIndex:0];
}

// Setup the layers with the page index.
- (void)setLayersPicturesWithIndex:(NSInteger)index {
    _currentPageIndex = index;
    [self setLayersPrimaryAlphaWithPageIndex:index];
    [self setFrontLayerPictureWithPageIndex:index];
    [self setBackLayerPictureWithPageIndex:index];
}

// Animate the fade-in/out (Cross-disolve) with the scrollView translation.
- (void)disolveBackgroundWithContentOffset:(float)offset {
    if (_currentState & ScrollingStateLooping){
        // Jump from the last page to the first.
        [self scrollingToFirstPageWithOffset:offset];
    } else {
        // Or just scroll to the next/previous page.
        [self scrollingToNextPageWithOffset:offset];
    }
}

// Handle alpha on layers when the auto-scrolling is looping to the first page.
- (void)scrollingToFirstPageWithOffset:(float)offset {
    // Compute the scrolling percentage on all the page.
    offset = (offset * _windowSize.width) / (_windowSize.width * [self numberOfPages]);
    
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
    [self.backLayerView setAlpha:backLayerAlpha];
    [self.frontLayerView setAlpha:frontLayerAlpha];
}

// Handle alpha on layers when we are scrolling to the next/previous page.
- (void)scrollingToNextPageWithOffset:(float)offset {
    // Current page index in scrolling.
    NSInteger page = (int)(offset);
    
    // Keep only the float value.
    float alphaValue = offset - (int)offset;
    
    // This is only when you scroll to the right on the first page.
    // That will fade-in black the first picture.
    if (alphaValue < 0 && _currentPageIndex == 0){
        [self.backLayerView setImage:nil];
        [self.frontLayerView setAlpha:(1 + alphaValue)];
        return;
    }
    
    // Switch pictures, and imageView alpha.
    if (page != _currentPageIndex ||
       (page == _currentPageIndex && 0.0 < offset && offset < 1.0))
        [self setLayersPicturesWithIndex:page];
    
    // Invert alpha for the front picture.
    float backLayerAlpha = alphaValue;
    float frontLayerAlpha = (1 - alphaValue);
    
    // Set alpha.
    [self.backLayerView setAlpha:backLayerAlpha];
    [self.frontLayerView setAlpha:frontLayerAlpha];
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Get scrolling position, and send the alpha values.
    float scrollingPosition = scrollView.contentOffset.x / _windowSize.width;
    [self disolveBackgroundWithContentOffset:scrollingPosition];
    
    if (self.scrollView.isTracking) {
        _currentState = ScrollingStateManual;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // Update the page index.
    [self.pageControl setCurrentPage:_currentPageIndex];
}

@end
