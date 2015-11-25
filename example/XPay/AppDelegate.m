//
//  AppDelegate.m
//  XPay
//
//  Created by S on 15/9/22.
//  Copyright © 2015年 S. All rights reserved.
//

#import "AppDelegate.h"
#import "XPay.h"
#import "XRegisterApp.h"

//  商户appid
#define appId               @"4ab6526f6d19fecfb3be6a07d7e62f1"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 注册XPay服务
    XRegisterApp * xRegister = [XRegisterApp shareInstance];
    [xRegister registerWithAppId:appId isDeug:YES withModuleType:XModulePay];
    
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    [XPay handleOpenURL:url withCompletion:^(XPayResultStatus status, NSString *memo, NSObject *attach) {
        NSLog(@"stauts -- %ld",(long)status);
        NSLog(@"memo -- %@",memo);
        NSLog(@"attach -- %@",attach);
    }];
    
    return YES;
}


@end
