/*
 iMedia Browser Framework <http://karelia.com/imedia/>
 
 Copyright (c) 2005-2009 by Karelia Software et al.
 
 iMedia Browser is based on code originally developed by Jason Terhorst,
 further developed for Sandvox by Greg Hulands, Dan Wood, and Terrence Talbot.
 The new architecture for version 2.0 was developed by Peter Baumgartner.
 Contributions have also been made by Matt Gough, Martin Wennerberg and others
 as indicated in source files.
 
 The iMedia Browser Framework is licensed under the following terms:
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in all or substantial portions of the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to permit
 persons to whom the Software is furnished to do so, subject to the following
 conditions:
 
	Redistributions of source code must retain the original terms stated here,
	including this list of conditions, the disclaimer noted below, and the
	following copyright notice: Copyright (c) 2005-2009 by Karelia Software et al.
 
	Redistributions in binary form must include, in an end-user-visible manner,
	e.g., About window, Acknowledgments window, or similar, either a) the original
	terms stated here, including this list of conditions, the disclaimer noted
	below, and the aforementioned copyright notice, or b) the aforementioned
	copyright notice and a link to karelia.com/imedia.
 
	Neither the name of Karelia Software, nor Sandvox, nor the names of
	contributors to iMedia Browser may be used to endorse or promote products
	derived from the Software without prior and express written permission from
	Karelia Software or individual contributors, as appropriate.
 
 Disclaimer: THE SOFTWARE IS PROVIDED BY THE COPYRIGHT OWNER AND CONTRIBUTORS
 "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
 LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE,
 AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 LIABLE FOR ANY CLAIM, DAMAGES, OR OTHER LIABILITY, WHETHER IN AN ACTION OF
 CONTRACT, TORT, OR OTHERWISE, ARISING FROM, OUT OF, OR IN CONNECTION WITH, THE
 SOFTWARE OR THE USE OF, OR OTHER DEALINGS IN, THE SOFTWARE.
*/

//  Created by Christoph Priebe on 2009-08-24.
//  Copyright 2009 Christoph Priebe. All rights reserved.

//----------------------------------------------------------------------------------------------------------------------

//	iMedia
#import "IMBCommon.h"
#import "IMBFlickrQueryEditor.h"
#import "IMBFlickrNode.h"
#import "IMBFlickrParser.h"




//----------------------------------------------------------------------------------------------------------------------

@implementation IMBFlickrQueryEditor

+ (IMBFlickrQueryEditor*) flickrQueryEditorForParser: (IMBFlickrParser*) parser {
	IMBFlickrQueryEditor* editor = [[IMBFlickrQueryEditor alloc] init];
	editor.parser = parser;
	return editor;
}


- (id) init {
    self = [super init];
    if (self != nil) {
        if (![NSBundle loadNibNamed:@"IMBFlickrQueryEditor" owner:self]) {
            NSAssert (false, @"Can't load 'IMBFlickrQueryEditor' nib.");
        }		
    }
    return self;
}


- (void) dealloc {
	_parser = nil;
	[super dealloc];
}


#pragma mark
#pragma mark Actions

- (IBAction) add: (id) sender {
	NSMutableDictionary* dict = [NSMutableDictionary dictionary];
	[dict setObject:@"Title" forKey:IMBFlickrNodePrefKey_Title];
	[dict setObject:[NSNumber numberWithInt:IMBFlickrNodeMethod_TagSearch] forKey:IMBFlickrNodePrefKey_Method];
	[dict setObject:@"Steve Jobs" forKey:IMBFlickrNodePrefKey_Query];	
	[_queriesController addObject:dict];
	[_title becomeFirstResponder];
}


- (IBAction) cancel: (id) sender {
	[self.parser loadCustomQueries];
	[self.window orderOut:sender];
}


- (IBAction) ok: (id) sender {
	[_queriesController commitEditing];
	[self.parser saveCustomQueries];
	[self.parser reloadCustomQueries];
	[self.window orderOut:sender];
}


#pragma mark
#pragma mark Properties

@synthesize parser = _parser;

@end