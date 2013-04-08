//
//  AppDelegate.m
//  FastLight
//
//  Created by Jonathan Gaull on 1/1/13.
//  Copyright (c) 2013 OneHeaded Llama. All rights reserved.
//

#import "AppDelegate.h"

#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (nonatomic) CGFloat initialBrightness;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [self turnOnLight];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[UIViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)turnOnLight {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (device.torchMode != AVCaptureTorchModeOn) {
        [device lockForConfiguration:nil];
        device.torchMode = AVCaptureTorchModeOn;
        [device unlockForConfiguration];
    }
    
    NSLog(@"idleTimer: %d", [UIApplication sharedApplication].idleTimerDisabled);
}

- (void)turnOffLight {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (device.torchMode != AVCaptureTorchModeOff) {
        [device lockForConfiguration:nil];
        device.torchMode = AVCaptureTorchModeOff;
        [device unlockForConfiguration];
    }
    
    NSLog(@"idleTimer: %d", [UIApplication sharedApplication].idleTimerDisabled);
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
    [self turnOffLight];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self turnOnLight];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
