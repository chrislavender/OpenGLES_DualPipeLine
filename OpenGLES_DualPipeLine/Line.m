//
//  Line.m
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/1/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "Line.h"

@implementation Line

+ (Line *)line
{
    return [[[self alloc]init] autorelease];
}

- (void)draw 
{
    glPushMatrix();
    
    glTranslatef(self.drawLocation.x, self.drawLocation.y, self.drawLocation.z);
    
    // CL: treating this like a subview so draw 
    // all objects in this view inside this push/ pop.
    [self.itemsToDraw makeObjectsPerformSelector:@selector(draw)];
    
    glPopMatrix();

}

@end
