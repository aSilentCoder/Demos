//
//  AppDelegate.m
//  Demos
//
//  Created by HK on 2018/10/12.
//  Copyright © 2018年 HK. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ViewController *vc = [[ViewController alloc] init];
//    vc.title = @"首页";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (UIViewController *)currentViewController
{
    if ([NSThread isMainThread]) {
        return [self getTopViewController];
    } else {
        NSLog(@"%s \n thread:%@",__func__,[NSThread currentThread]);

        __block UIViewController *vc = nil;
        dispatch_sync(dispatch_get_main_queue(), ^{
            vc = [self getTopViewController];
        });
        return vc;
    }
}

+ (UIViewController *)getTopViewController {
    UINavigationController *routerVC = nil;
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabbarController  = (UITabBarController *)rootViewController;
        UIViewController *selectedVC = tabbarController.selectedViewController;
        if ([selectedVC isKindOfClass:[UINavigationController class]]) {
            routerVC = (UINavigationController *)selectedVC;
        }
    }else if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        routerVC = (UINavigationController *)rootViewController;
    }
    
    return routerVC.topViewController;
}

@end
