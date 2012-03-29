//
//  Page.m
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/1/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "Page.h"
#import "Line.h"

@interface Page()
{
    }
@property CGRect frame;
@end

@implementation Page
@synthesize frame = _frame;

+ (Page *)pageForFrame:(CGRect)frame
{
    return [[[self alloc]initWithFrame:frame]autorelease];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super init]) {
        self.frame = frame;
    }
    return self;
}

- (void)draw 
{
    glPushMatrix();
    
    // CL: treating this like a subview so draw 
    // all objects in this view inside this push/ pop.
    [self.itemsToDraw makeObjectsPerformSelector:@selector(draw)];
    
    glPopMatrix();
}

@end
