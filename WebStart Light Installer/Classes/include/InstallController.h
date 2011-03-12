/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @header      
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

@interface InstallController: NSWindowController
{
@protected
    
    NSProgressIndicator  * installProgress;
    NSTextField          * installPhase;
    NSTextField          * installStatus;
    NSTextField          * installTitle;
    NSButton             * installButton;
    NSButton             * quitButton;
    NLUIInstaller        * installer;
    
@private
    
    id r1;
    id r2;
}

@property( nonatomic, retain ) IBOutlet NSProgressIndicator  * installProgress;
@property( nonatomic, retain ) IBOutlet NSTextField          * installPhase;
@property( nonatomic, retain ) IBOutlet NSTextField          * installStatus;
@property( nonatomic, retain ) IBOutlet NSTextField          * installTitle;
@property( nonatomic, retain ) IBOutlet NSButton             * installButton;
@property( nonatomic, retain ) IBOutlet NSButton             * quitButton;

- ( IBAction )install: ( id )sender;

@end
