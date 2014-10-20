//
//  AppDelegate.m
//  ICETutorial
//
//  Created by Patrick Trillsam on 25/03/13.
//  Copyright (c) 2014 https://github.com/icepat/ICETutorial. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Init the pages texts, and pictures.
    ICETutorialPage *layer1 = [[ICETutorialPage alloc] initWithTitle:@"Picture 1"
                                                            subTitle:@"Champs-Elysées by night"
                                                         pictureName:@"tutorial_background_00@2x.jpg"
                                                            duration:3.0];
    ICETutorialPage *layer2 = [[ICETutorialPage alloc] initWithTitle:@"Picture 2"
                                                            subTitle:@"The Eiffel Tower with\n cloudy weather"
                                                         pictureName:@"tutorial_background_01@2x.jpg"
                                                            duration:3.0];
    ICETutorialPage *layer3 = [[ICETutorialPage alloc] initWithTitle:@"Picture 3"
                                                            subTitle:@"An other famous street of Paris"
                                                         pictureName:@"tutorial_background_02@2x.jpg"
                                                            duration:3.0];
    ICETutorialPage *layer4 = [[ICETutorialPage alloc] initWithTitle:@"Picture 4"
                                                            subTitle:@"The Eiffel Tower with a better weather"
                                                         pictureName:@"tutorial_background_03@2x.jpg"
                                                            duration:3.0];
    ICETutorialPage *layer5 = [[ICETutorialPage alloc] initWithTitle:@"Picture 5"
                                                            subTitle:@"The Louvre's Museum Pyramide"
                                                         pictureName:@"tutorial_background_04@2x.jpg"
                                                            duration:3.0];
    NSArray *tutorialLayers = @[layer1,layer2,layer3,layer4,layer5];

    // Set the common style for the title.
    ICETutorialLabelStyle *titleStyle = [[ICETutorialLabelStyle alloc] init];
    [titleStyle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17.0f]];
    [titleStyle setTextColor:[UIColor whiteColor]];
    [titleStyle setLinesNumber:1];
    [titleStyle setOffset:180];
    [[ICETutorialStyle sharedInstance] setTitleStyle:titleStyle];
    
    // Set the subTitles style with few properties and let the others by default.
    [[ICETutorialStyle sharedInstance] setSubTitleColor:[UIColor whiteColor]];
    [[ICETutorialStyle sharedInstance] setSubTitleOffset:150];
    
    // Init tutorial.
    self.viewController = [[ICETutorialController alloc] initWithPages:tutorialLayers
                                                              delegate:self];
    
    // Run it.
    [self.viewController startScrolling];
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - ICETutorialController delegate
- (void)tutorialController:(ICETutorialController *)tutorialController scrollingFromPageIndex:(NSUInteger)fromIndex toPageIndex:(NSUInteger)toIndex {
    NSLog(@"Scrolling from page %lu to page %lu.", (unsigned long)fromIndex, (unsigned long)toIndex);
}

- (void)tutorialControllerDidReachLastPage:(ICETutorialController *)tutorialController {
    NSLog(@"Tutorial reached the last page.");
}

- (void)tutorialController:(ICETutorialController *)tutorialController didClickOnLeftButton:(UIButton *)sender {
    NSLog(@"Button 1 pressed.");
}

- (void)tutorialController:(ICETutorialController *)tutorialController didClickOnRightButton:(UIButton *)sender {
    NSLog(@"Button 2 pressed.");
    NSLog(@"Auto-scrolling stopped.");
    
    [self.viewController stopScrolling];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
