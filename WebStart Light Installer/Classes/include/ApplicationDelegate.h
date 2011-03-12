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

@class AboutController;
@class InstallController;

@interface ApplicationDelegate: NSObject < NSApplicationDelegate >
{
@protected
    
    AboutController   * aboutController;
    InstallController * installController;
    BOOL                installing;
    
@private
    
    NSWindow * window;
}

@property( assign                        ) IBOutlet NSWindow * window;
@property( assign, getter = isInstalling )          BOOL       installing;

- ( IBAction )showAboutWindow: ( id )sender;

@end
