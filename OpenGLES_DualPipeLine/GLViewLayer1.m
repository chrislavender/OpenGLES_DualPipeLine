//
//  GLViewLayer1.m
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 2/28/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "GLViewLayer1.h"

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@implementation GLViewLayer1
@synthesize itemsToDraw = _itemsToDraw;

- (id)init {
    
    if (self = [super init]) {
        
    }
    return self;
}

- (void)draw 
{
    glTranslatef(100.0, 100.0, 0.0);
        
    // CL: so we can feed in the vertices and colors
    glVertexPointer(3, GL_FLOAT, sizeof(Vertex), &rest_half_aloneVertices[0]);
    glColorPointer(4, GL_FLOAT, sizeof(Vertex), &rest_half_aloneVertices[0].color[0]);
    
    // CL: go for it.
    glDrawElements(GL_TRIANGLES, sizeof(rest_half_aloneIndices)/sizeof(GLuint), GL_UNSIGNED_INT, rest_half_aloneIndices);
    
    [self.itemsToDraw draw];

}

@end
