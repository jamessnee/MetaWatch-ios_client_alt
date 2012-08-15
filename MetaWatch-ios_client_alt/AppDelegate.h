//
//  AppDelegate.h
//  MetaWatch-ios_client_alt
//
//  Created by James Snee on 15/08/2012.
//  Copyright (c) 2012 James Snee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWManager.h"

#define MWCONNECTION_TIMEOUT 99999;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, MWManagerProtocol>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
