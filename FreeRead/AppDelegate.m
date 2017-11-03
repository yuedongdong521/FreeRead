//
//  AppDelegate.m
//  FreeRead
//
//  Created by ispeak on 2017/11/2.
//  Copyright © 2017年 ydd. All rights reserved.
//

#import "AppDelegate.h"
#import "BookCase.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    BookCase *book = [[BookCase alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:book];
    
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    tabBar.viewControllers = @[navi];
    self.window.rootViewController = tabBar;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
#pragma mark 网络检查
    Reachability *r= [Reachability reachabilityForInternetConnection];
    
    if ([r currentReachabilityStatus] == NotReachable) {
        
        UIAlertView *unavailAlert = [[UIAlertView alloc] initWithTitle:@"警告"message:@"无网络连接,请检查网络" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        
        [unavailAlert show];
        
    }
#pragma mark 监控网络环境
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.remoteHostStatus = [Reachability reachabilityForInternetConnection];
    [self.remoteHostStatus startNotifier];
    return YES;
}

-(void)reachabilityChanged:(NSNotification *)note

{
    //    // 1.检测wifi状态
    //    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    //
    //    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    //    Reachability *conn = [Reachability reachabilityForInternetConnection];
    //    // NSLog(@"44");
    //
    //    // 3.判断网络状态
    //    // currentReachabilityStatus方法获取网络连接状态，如果网络连接状态返回NotReachable，则表明这种类型的网络暂未连接。
    //    // 有WiFi 和手机网络 用 WiFi
    //    // 没有WiFi用手机网络
    //    // 没网络 就 没有 网络
    //    if ([wifi currentReachabilityStatus] != NotReachable) {
    //        // 有wifi
    //        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"当前网络状态为wifi" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //        [alview show];
    //
    //    } else if ([conn currentReachabilityStatus] != NotReachable) {
    //        // 没有使用wifi, 使用手机自带网络进行上网
    //        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"当前网络状态为2G/3G/4G,看视频时请在WiFi状态下,土豪随意" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //        [alview show];
    //
    //
    //    } else { // 没有网络
    //        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"请连接网络" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //        [alview show];
    //
    //    }
    
    self.remoteHostStatus = [Reachability reachabilityForInternetConnection];
    
    if ([self.remoteHostStatus currentReachabilityStatus] == NotReachable) {
        
        UIAlertView *unavailAlert = [[UIAlertView alloc] initWithTitle:@"警告"message:@"无网络连接,请检查网络" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        
        [unavailAlert show];
        
    }
    
    
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


@end
