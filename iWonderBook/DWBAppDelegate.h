//
//  DWBAppDelegate.h
//  doWonderBook
//
//  Created by David Dicsöfi on 22.02.14.
//  Copyright (c) 2014 doSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWBAppDelegate : UIResponder <UIApplicationDelegate>

extern NSMutableDictionary *gCategories2Pages;

@property (strong, nonatomic) UIWindow *window;


- (NSURL *)applicationDocumentsDirectory;

@end
