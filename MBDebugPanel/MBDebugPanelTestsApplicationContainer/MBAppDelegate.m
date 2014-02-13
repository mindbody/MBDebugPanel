//
//  MBAppDelegate.m
//  MBDebugPanelTestsApplicationContainer
//
//  Created by Matthew Holden on 2/12/14.
//
//

#import "MBAppDelegate.h"

@implementation MBAppDelegate

// This entire "App" is just a test host for the MBDebugPanelTests target,
// When the test target was running independent of a test host (i.e. as a "logic test"),
// UITableView methods were not behaving correctly.  Running the tests inside an app
// container solves our troubles.

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:[UIViewController new]];
    return YES;
}
@end
