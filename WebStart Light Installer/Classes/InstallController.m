/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * file         
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "InstallController.h"
#import "ApplicationDelegate.h"

@implementation InstallController

@synthesize installProgress;
@synthesize installPhase;
@synthesize installStatus;
@synthesize installTitle;
@synthesize installButton;
@synthesize quitButton;

- ( id )init
{
    return [ super initWithWindowNibName: @"Install" ];
}

- ( void )dealloc
{
    [ installProgress release ];
    [ installPhase    release ];
    [ installStatus   release ];
    [ installTitle    release ];
    [ installButton   release ];
    [ quitButton      release ];
    [ installer       release ];
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    [ installPhase setStringValue:  @"" ];
    [ installStatus setStringValue: @"" ];
}

- ( void )launchApplication
{
    [ [ NSWorkspace sharedWorkspace ] launchApplication: @"WebStart-Light.app" ];
    [ NSApp terminate: nil ];
}

- ( void )installMySQLConfig: ( id )nothing
{
    NLApplication * app;
    char          * args[ 3 ];
    OSStatus        status;
    
    ( void )nothing;
    
    app = ( NLApplication * )NSApp;
    
    if( [ [ NSFileManager defaultManager ] fileExistsAtPath: @"/etc/my.cnf" ] )
    {
        args[ 0 ] = "/etc/my.cnf";
        args[ 1 ] = ( char * )[ @"/etc/my.cnf.webstart-light.save" cStringUsingEncoding: NSASCIIStringEncoding ];
        args[ 2 ] = NULL;
        
        status = [ app.execution executeWithPrivileges: "/bin/mv" arguments: args io: NULL ];
    }
    
    args[ 0 ] = ( char * )[ [ [ NSBundle mainBundle ] pathForResource: @"my" ofType: @"cnf" ] cStringUsingEncoding: NSASCIIStringEncoding ];
    args[ 1 ] = "/etc/my.cnf";
    args[ 2 ] = NULL;
    
    status = [ app.execution executeWithPrivileges: "/bin/mv" arguments: args io: NULL ];
}

- ( void )fixPermissions: ( id )nothing
{
    NLApplication * app;
    char          * args[ 4 ];
    OSStatus        status;
    
    ( void )nothing;
    
    args[ 0 ] = "-R";
    args[ 1 ] = "_mysql:_mysql";
    args[ 2 ] = "/usr/local/webstart-light/data/mysql";
    args[ 3 ] = NULL;
    app       = ( NLApplication * )NSApp;
    
    status = [ app.execution executeWithPrivileges: "/usr/sbin/chown" arguments: args io: NULL ];
}

- ( void )installationComplete: ( NLEvent * )event
{
    NSApplication * app;
    
    app = NSApp;
    
    ( void )event;
    
    [ ( ApplicationDelegate * )( app.delegate ) setInstalling: NO ];
    
    [ installTitle  setStringValue: L10N( @"InstallDone" ) ];
    [ installButton setTitle:       L10N( @"InstallLaunch" ) ];
    [ installStatus setStringValue: L10N( @"" ) ];
    [ installPhase  setStringValue: L10N( @"" ) ];
    [ installButton setEnabled:     YES ];
    [ installButton setAction:      @selector( launchApplication ) ];
    [ self performSelectorOnMainThread: @selector( fixPermissions: ) withObject: nil waitUntilDone: YES ];
}

- ( IBAction )install: ( id )sender
{
    NSApplication * app;
    
    app = NSApp;
    
    ( void )sender;
    
    [ ( ApplicationDelegate * )( app.delegate ) setInstalling: YES ];
    
    [ installPhase    setStringValue:  L10N( @"InstallInit" ) ];
    [ installStatus   setStringValue:  L10N( @"InstallWait" ) ];
    [ installTitle    setStringValue:  L10N( @"InstallTitle" ) ];
    [ installButton   setEnabled: NO ];
    [ installProgress setIndeterminate: YES ];
    [ installProgress startAnimation: nil ];
    
    installer = [ NLUIInstaller installerWithPackage: [ [ NSBundle mainBundle ] pathForResource: @"WebStart-Light" ofType: @"pkg" ] ];
    
    installer.progressBar   = installProgress;
    installer.phaseText     = installPhase;
    installer.statusText    = installStatus;
    installer.installButton = installButton;
    installer.quitButton    = quitButton;
    installer.completeSound = [ NSSound soundNamed: @"complete.aif" ];
    
    [ installProgress setIndeterminate: NO ];
    [ installer addEventListener: @"InstallerComplete" target: self selector: @selector( installationComplete: ) ];
    /*[ self performSelectorOnMainThread: @selector( installMySQLConfig: ) withObject: nil waitUntilDone: YES ];*/
    
    if( [ installer install ] != 0 )
    {
        [ installProgress setIndeterminate: NO ];
        [ ( ApplicationDelegate * )( app.delegate ) setInstalling: NO ];
    }

}

@end
