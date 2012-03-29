//
//  GlyphBase.m
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/1/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "GlyphBase.h"

@implementation GlyphBase
@synthesize drawLocation    = _drawLocation;
@synthesize itemsToDraw     = _itemsToDraw;
@synthesize drawData        = _drawData;

- (void)dealloc
{
    [_itemsToDraw   release];
    [_drawData      release];
    [super dealloc];
}

- (void)draw 
{
    [self.itemsToDraw makeObjectsPerformSelector:@selector(draw)];
}

@end
