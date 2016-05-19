//
//  AppDelegate.m
//  SqliteExample
//
//  Created by Manju Sj on 5/19/16.
//  Copyright (c) 2016 Manju Sj. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self copyDatabaseIfNeed];
    return YES;
}

-(void)copyDatabaseIfNeed{

    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    NSString *dbpath=[self getDBPath];
    BOOL success=[fileManager fileExistsAtPath:dbpath];
    if (!success) {
        NSString *defaultPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"mydatabase.sqlite"];
        success =[fileManager copyItemAtPath:defaultPath toPath:dbpath error:&error];
        if (!success) {
            NSLog(@"Failed to create writable database with error message %@",[error localizedDescription]);
        }
    }
    

}

-(NSString *)getDBPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDir=[paths objectAtIndex:0];
    [documentsDir stringByAppendingPathComponent:@"mydatabase.sqlite"];
    NSLog(@"%@",documentsDir);
    return documentsDir;
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
