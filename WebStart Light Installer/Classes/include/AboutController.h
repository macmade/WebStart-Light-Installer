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

@interface AboutController: NSWindowController
{
@protected
    
    NSTextField * version;
    
@private
    
    id r1;
    id r2;
}

@property( nonatomic, retain ) IBOutlet NSTextField * version;

@end
