//
//  AppDelegate.m
//  test_app
//
//  Created by Utsab Saha on 10/24/15.
//  Copyright (c) 2015 My Company. All rights reserved.
//

#import "AppDelegate.h"
#include "MasterViewController.h"
#include <SecurityFoundation/SFAuthorization.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic,strong) IBOutlet MasterViewController *masterViewController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    // 1. Create the master View Controller
    self.masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    
    // 2. Add the view controller to the Window's content view
    [self.window.contentView addSubview:self.masterViewController.view];
    self.masterViewController.view.frame = ((NSView*)self.window.contentView).bounds;
    
    //[self changeSleepSettings];
    //[self speak];
    
//    [self.window setOpaque:NO]; // YES by default
//    NSColor *semiTransparentBlue =
//    [NSColor colorWithDeviceRed:0.0 green:0.0 blue:1.0 alpha:0.5];
//    [self.window setBackgroundColor:semiTransparentBlue];
    
    [self.window setBackgroundColor:[NSColor whiteColor]];
    
}




- (void) changeSleepSettings {
    NSLog(@"here");
    
    NSTask *task = [[NSTask alloc] init];
    
    NSArray *arguments = [NSArray arrayWithObjects: @"hurrah", @"wooot", nil];
    
    [task setLaunchPath:@"/bin/echo"];
    [task setArguments:arguments];
    [task setStandardOutput:[NSPipe pipe]];
    [task setStandardError:[NSPipe pipe]];
    
    
}

- (void) speak {
    SFAuthorization *authorization = [SFAuthorization authorization];
    NSError *err;
    BOOL result = [authorization obtainWithRight:nil flags:kAuthorizationFlagExtendRights error:nil];
    
     if (!result)
    {
        NSLog(@"SFAuthorization error:");
        return;
    }
     
    NSTask *task = [[NSTask alloc] init];
    
    //2
    task.launchPath = @"/usr/bin/pmset";
    
    //3
//    NSString* speakingPhrase = @"Hurrah";
    task.arguments  = @[@"sleep", @"25"];
    
    //4
    [task launch];
    
    //5
    //[task waitUntilExit];
    
//    NSPipe *outputPipe               = [[NSPipe alloc] init];
//    task.standardOutput = outputPipe;
//    
//    NSData *output = [[outputPipe fileHandleForReading] readDataToEndOfFile];
//    NSString *outStr = [[NSString alloc] initWithData:output encoding:NSUTF8StringEncoding];
//    NSLog(outStr);
//    
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
