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

#import "AboutController.h"

@implementation AboutController

@synthesize version;

- ( id )init
{
    return [ super initWithWindowNibName: @"About" ];
}

- ( void )dealloc
{
    [ version release ];
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    [ version setStringValue: [ NSString stringWithFormat: L10N( @"VersionFormat" ), [ [ NSBundle mainBundle ] objectForInfoDictionaryKey: @"CFBundleShortVersionString" ] ] ];
}

@end
