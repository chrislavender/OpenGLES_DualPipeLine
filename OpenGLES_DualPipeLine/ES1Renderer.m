//
//  ES1Renderer.m
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 2/27/12.
//  Copyright (c) 2012 GnarlyDogMusic. All rights reserved.
//

#import "ES1Renderer.h"

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface ES1Renderer()
{
    EAGLContext *context;
    
    GLuint defaultFrameBuffer;
    GLuint colorRenderBuffer;
}
@end

@implementation ES1Renderer
@synthesize thingsToDraw    = _thingsToDraw;
@synthesize backingWidth    = _backingWidth;
@synthesize backingHeight   = _backingHeight;

- (void)dealloc
{
    // Tear down GL
    if (defaultFrameBuffer)
    {
        glDeleteFramebuffersOES(1, &defaultFrameBuffer);
        defaultFrameBuffer = 0;
    }
    
    if (colorRenderBuffer)
    {
        glDeleteRenderbuffersOES(1, &colorRenderBuffer);
       colorRenderBuffer = 0;
    }
    
    // Tear down context
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
    
    [context release];
    context = nil;
    
    [_thingsToDraw release];
    
    [super dealloc];
}

// Create an OpenGL ES 1.1 context
- (id)init
{
    if ((self = [super init]))
    {
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context])
        {
            [self release];
            return nil;
        }

        // Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
        glGenFramebuffersOES(1, &defaultFrameBuffer);
        glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFrameBuffer);
        
        glGenRenderbuffersOES(1, &colorRenderBuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES,colorRenderBuffer);
        
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES,colorRenderBuffer);
    }
    return self;
}

//const Vertex TESTVertices[] = {
//    {{20, 20, 0}, {0, 0, 0, .8}},
//    {{70, 20, 0}, {0, 0, 0, .8}},
//    {{20, 70, 0}, {0, 0, 0, .8}},
//    {{70, 70, 0}, {0, 0, 0, .8}}
//};
//
//const GLuint TESTIndices[] = {
//    0, 2, 3, 3, 1, 0
//};

- (void)render;
{
    // CL: setup the Viewport
    glViewport(0, 0, _backingWidth, _backingHeight);
    
    // CL: load identity for the Projection
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();    
    // CL: reset coordinates to pixels for the Projection
    glOrthof(0.0, _backingWidth, _backingHeight, 0.0, -1.0, 1.0);
    
    // CL: load identity for the ModelView
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
        
    // CL: set the backing color and wipe the screen.
    glClearColor(1.0, 1.0, 1.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    // CL: enable the GL vertex and color arrays
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);

    // CL: DRAW!!!
    //glScalef(.5, .5, 0.0);
    [self.thingsToDraw makeObjectsPerformSelector:@selector(draw)];
    
    // CL: disable the GL vertex and color arrays)
    glDisableClientState(GL_VERTEX_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    
//    GLenum err = glGetError();
//     if (err != GL_NO_ERROR)
//     NSLog(@"Error in frame. glError: 0x%04X", err);
	
    // CL: bind the buffer and show it off
    glBindRenderbufferOES(GL_RENDERBUFFER_OES,colorRenderBuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer
{	
    // Allocate color buffer backing based on the current layer size
    glBindRenderbufferOES(GL_RENDERBUFFER_OES,colorRenderBuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
    
    //CL: set the backingWidth and Height ivars to the Buffer's
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &_backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &_backingHeight);
    
    // NSLog(@"Width: %d, height: %d // [%@ %@]", backingWidth, backingHeight, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
    {
        NSLog(@"Failed to make complete framebuffer object %x // [%@ %@]", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES), NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return NO;
    }
    return YES;
}

@end
