//
//  AppDelegate.m
//  MetaWatch-ios_client_alt
//
//  Created by James Snee on 15/08/2012.
//  Copyright (c) 2012 James Snee. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation AppDelegate

#pragma mark - MWManagerProtocol

- (void) MWMDidDiscoveredWritePort{
	NSLog(@"MWMDidDiscoveredWritePort");
}

- (void) MWM:(MWManager*)mwm didDisconnectPeripheral:(CBPeripheral *)peripheral withError:(NSError*)err{
	NSLog(@"MWMDidDisconnectPeripheralWithError");
}

- (void) MWM:(MWManager*)mwm didConnectPeripheral:(CBPeripheral *)peripheral{
	NSLog(@"MWMDidConnectPeripheral");
}

- (void) MWMCheckEvent:(NSTimeInterval)timestamp{
	NSLog(@"MWMCheckEvent");
}

- (void) MWMBtn:(unsigned char)btnIndex atMode:(unsigned char)mode pressedForType:(unsigned char)type withMsg:(unsigned char)msg{
	NSLog(@"MWMBtnAtModePressedForTypeWithMsg");
}

- (void) MWMGrantedLocalAppMode{
	NSLog(@"MWMGrantedLocalAppMode");
}

- (void) MWMReleasedLocalAppMode{
	NSLog(@"MWMReleasedLocalAppMode");
}

#pragma mark - Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	//App stuff
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	UIViewController *viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
	UIViewController *viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
	self.tabBarController = [[UITabBarController alloc] init];
	self.tabBarController.viewControllers = @[viewController1, viewController2];
	self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
	
	//Watch connection stuff
	[MWManager sharedManager].delegate = self;
	
	//Start a scan in a seperate thread - report back home when something's found
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
	dispatch_async(queue, ^{
		MWManager *manager = [MWManager sharedManager];
		//Start the scan
		if (manager.statusCode==0) {
			[manager startScan];
		}
		int timeout = MWCONNECTION_TIMEOUT; //Spin spin spin - until timeout or it connects
		while(manager.statusCode!=1||timeout<0){
			if (manager.statusCode==2)
				break;
			timeout = timeout - 1;
			continue;
		}
		if (timeout<0) { //It didn't connect in time
			[manager stopScan];
			dispatch_sync(dispatch_get_main_queue(), ^{
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Couldn't connect" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
			});
		}else{ //It connected
			dispatch_sync(dispatch_get_main_queue(), ^{
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connected!" message:@"Ready to go!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
			});
		}
	});
    return YES;
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

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
