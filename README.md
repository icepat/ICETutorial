ICETutorial
===========

### Welcome to ICETutorial.
This small project is an implementation of the newly tutorial introduced by the Path 3.X app.
Very simple and efficient tutorial, composed with N full-screen pictures that you can swipe for switching to the next/previous page.

Here are the features :
* Compose your own tutorial with N pictures
* Fixed incrusted title (can be easily replaced by an UIImageView, or just removed)
* Scrolling sub-titles for page, with associated descriptions (change the texts, font, color...)
* Auto-scrolling (enable/disable, loop, setup duration)
* Cross fade between next/previous background
* Easy to use block access to button's events.

![ICETutorial](https://github.com/icepat/ICETutorial/blob/master/screen_shot.jpg?raw=true)

### Setting-up the ICETutorial
The code is commented, and I guess, easy to read/understand/modify.
All the available settings for the scrolling are located in the header : ICETutorial.h :

**Texts and pictures :**
```objective-c
    // Init the pages texts, and pictures.
    ICETutorialPage *layer1 = [[ICETutorialPage alloc] initWithSubTitle:@"Picture 1"
                                                            description:@"Champs-Elysées by night"
                                                            pictureName:@"tutorial_background_00@2x.jpg"];
    ICETutorialPage *layer2 = [[ICETutorialPage alloc] initWithSubTitle:@"Picture 2"
                                                            description:@"The Eiffel Tower with\n cloudy weather"
                                                            pictureName:@"tutorial_background_01@2x.jpg"];
    [...] 
```

**Common styles for SubTitles and Descriptions :**
```objective-c
    // Set the common style for SubTitles and Description (can be overrided on each page).
    ICETutorialLabelStyle *subStyle = [[ICETutorialLabelStyle alloc] init];
    [subStyle setFont:TUTORIAL_SUB_TITLE_FONT];
    [subStyle setTextColor:TUTORIAL_LABEL_TEXT_COLOR];
    [subStyle setLinesNumber:TUTORIAL_SUB_TITLE_LINES_NUMBER];
    [subStyle setOffset:TUTORIAL_SUB_TITLE_OFFSET];
    
    ICETutorialLabelStyle *descStyle = [[ICETutorialLabelStyle alloc] init];
    [descStyle setFont:TUTORIAL_DESC_FONT];
    [descStyle setTextColor:TUTORIAL_LABEL_TEXT_COLOR];
    [descStyle setLinesNumber:TUTORIAL_DESC_LINES_NUMBER];
    [descStyle setOffset:TUTORIAL_DESC_OFFSET];

    // Load into an array.
    NSArray *tutorialLayers = @[layer1,layer2,layer3,layer4,layer5];
  
```

**Init and load :**
```objective-c
    self.viewController = [[ICETutorialController alloc] initWithNibName:@"ICETutorialController_iPhone"
                                                                  bundle:nil
                                                                andPages:tutorialLayers];

    // Set the common styles, and start scrolling (auto scroll, and looping enabled by default)
    [self.viewController setCommonPageSubTitleStyle:subStyle];
    [self.viewController setCommonPageDescriptionStyle:descStyle];

    // Set button 1 action.
    [self.viewController setButton1Block:^(UIButton *button){
        NSLog(@"Button 1 pressed.");
    }];
    
    // Set button 2 action, stop the scrolling.    
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewController setButton2Block:^(UIButton *button){
        NSLog(@"Button 2 pressed.");
        NSLog(@"Auto-scrolling stopped.");
        
        [weakSelf.viewController stopScrolling];
    }];

    // Run it.
    [self.viewController startScrolling];
```

**The title is located in the ICETutorial.m :**
```objective-c
// Setup the Title Label.
- (void)setOverlayTitle{
    // ...or change by an UIImageView if you need it.
    [_overlayTitle setText:@"Welcome"];
}
```

Checkout the others projects available on my account [@Icepat](https://github.com/icepat/).

Questions or ideas : patrick.trillsam@gmail.com.


###License :

The MIT License

Copyright (c) 2013 Patrick Trillsam - ICETutorial

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
