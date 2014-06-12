//
//  AppDelegate.h
//
//
//  Created by Patrick Trillsam on 25/03/13.
//  Copyright (c) 2013 Patrick Trillsam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICETutorialController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,ICETutorialControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ICETutorialController *viewController;

@end
