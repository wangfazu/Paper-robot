//
//  AppDelegate.m
//  幻境
//
//  Created by mac on 17/8/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    
    ViewController *mainVC = [[ViewController alloc]init];
    mainVC.view.backgroundColor = [UIColor whiteColor];
    mainVC.tabBarItem.title = @"主页";
    
    TangShiViewController *tangShiVC = [[TangShiViewController alloc]init];
    tangShiVC.view.backgroundColor = [UIColor blueColor];
    tangShiVC.tabBarItem.title = @"唐诗";
    
    SongCiViewController *songCiVC = [[SongCiViewController alloc]init];
    songCiVC.view.backgroundColor = [UIColor redColor];
    songCiVC.tabBarItem.title = @"宋词";
    
    Chat_ViewController *chatVC = [Chat_ViewController new];
    
    UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    UINavigationController *tangShiNav = [[UINavigationController alloc]initWithRootViewController:tangShiVC];
    UINavigationController *songCiNav = [[UINavigationController alloc]initWithRootViewController:songCiVC];
    UINavigationController *chatNav = [[UINavigationController new]initWithRootViewController:chatVC];
    
    [tabBar addChildViewController:chatNav];
    [tabBar addChildViewController:tangShiNav];
    [tabBar addChildViewController:songCiNav];
    [tabBar addChildViewController:mainNav];
    /**
     *  从DELEGATE中获取使用View权限，然后将管理权限移交给，已经设置好的tabBar
     */
    [[[UIApplication sharedApplication]delegate]window].rootViewController =tabBar;
    
        return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
