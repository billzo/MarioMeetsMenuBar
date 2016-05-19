//
//  MenuBarPrefController.m
//  MarioMeetsMenuBar
//
//  Created by Stefan Popp on 13.07.15.
//  Copyright (c) 2015 SwiftBlog. All rights reserved.
//

#import "MarioPrefController.h"
#import <AppKit/AppKit.h>

@interface MarioPrefController ()

@property NSUserDefaults *defaults;
@property (weak) IBOutlet NSButton *launchSwitch;

@end

@implementation MarioPrefController

#pragma mark - Settings and view configuration
- (void)configurePreview {
    [self readSettings];
    [_launchSwitch setState:[_defaults boolForKey:@"launchOnStart"]];
}

- (void)readSettings {
    _defaults = [[NSUserDefaults alloc] initWithSuiteName:@"de.swift-blog.mariomeetsmenubar"];
    [_defaults synchronize];
}

#pragma mark - Application helper

- (BOOL)appIsRunning {
    NSArray *apps = [NSRunningApplication runningApplicationsWithBundleIdentifier:@"de.SwiftBlog.MarioMeetsMenuBar"];
    return (apps.count > 0);
}


- (void)terminateMarioMenuApp {
    
    if (! [self appIsRunning]) {
        return;
    }
    
    NSArray *apps = [NSRunningApplication runningApplicationsWithBundleIdentifier:@"de.SwiftBlog.MarioMeetsMenuBar"];
    NSRunningApplication *app = apps[0];
    [app forceTerminate];
}

#pragma mark - Actions

- (IBAction)uninstallApplicationClicked:(NSButton *)sender {
    NSAlert *alert = [NSAlert new];
    [alert addButtonWithTitle:@"Uninstall"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert setMessageText:@"Are you sure to uninstall the Mario menu bar?"];
    [alert setInformativeText:@"Uninstall MarioMeetsMenuBar"];
    [alert setAlertStyle:NSCriticalAlertStyle];
    
    NSWindow *window = [NSApplication sharedApplication].keyWindow;
    [alert beginSheetModalForWindow:window completionHandler:^(NSModalResponse returnCode) {
        
    }];
    return;
}

- (IBAction)quitApplicationClicked:(NSButton *)sender {
    if (! [self appIsRunning]) {
        NSAlert *alert = [NSAlert new];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"MarioMeetsMenuBar is not running"];
        [alert setInformativeText:@"MarioMeetsMenuBar"];
        [alert setAlertStyle:NSInformationalAlertStyle];
        [alert runModal];
        return;
    }
    
    [self terminateMarioMenuApp];
}

- (IBAction)openSwiftBlogClicked:(NSButton *)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.swift-blog.de/"]];
}

- (IBAction)startApplicationClicked:(NSButton *)sender {
    
    if(![[NSWorkspace sharedWorkspace] launchApplication:@"/Applications/MarioMeetsMenuBar.app"])
        NSLog(@"Path Finder failed to launch");
}

@end
