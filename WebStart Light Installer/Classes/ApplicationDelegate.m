/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @file        
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "ApplicationDelegate.h"
#import "AboutController.h"
#import "InstallController.h"

@implementation ApplicationDelegate

@synthesize window;
@synthesize installing;

- ( void )applicationDidFinishLaunching: ( NSNotification * )notification
{
    ( void )notification;
    
    installController = [ InstallController new ];
    
    [ installController.window center ];
    [ installController showWindow: self ];
    [ NSApp activateIgnoringOtherApps: YES ];
}

- ( IBAction )showAboutWindow: ( id )sender
{
    if( aboutController == nil )
    {
        aboutController = [ AboutController new ];
    }
    
    ( void )sender;
    
    [ aboutController.window center ];
    [ aboutController showWindow: sender ];
    [ NSApp activateIgnoringOtherApps: YES ];
}

- ( NSApplicationTerminateReply )applicationShouldTerminate: ( NSApplication * )sender
{
    NSAlert * alert;
    
    if( installing == YES )
    {
        alert = [ [ NSAlert alloc ] init ];
        
        [ alert addButtonWithTitle:  L10N( @"OK" ) ];
        [ alert setMessageText:      L10N( @"InstallProgress" ) ];
        [ alert setInformativeText:  L10N( @"InstallProgressText" ) ];
        [ alert setAlertStyle: NSCriticalAlertStyle ];
        
        NSBeep();
        
        [ alert runModal ];
        [ alert release ];
        
        return NSTerminateCancel;
    }
    
    ( void )sender;
    
    return NSTerminateNow;
}

@end
