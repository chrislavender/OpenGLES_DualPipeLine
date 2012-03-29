//
//  EAGLView.m
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 2/27/12.
//  Copyright (c) 2012 GnarlyDogMusic. All rights reserved.
//

#import "EAGLView.h"

#import "ES1Renderer.h"
#import "ES2Renderer.h"

#define _ForceES1_ 1

@interface EAGLView ()
{
    CADisplayLink   *_displayLink;
}
@end

@implementation EAGLView
@synthesize renderer = _renderer;

+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

- (void)dealloc
{
    [_displayLink invalidate];

    [_renderer release];
    [super dealloc];
}

- (void)startDisplayLink {
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];    
}

- (void)stopDisplayLink {
    [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (BOOL)setup
{
    BOOL result = YES;
    
    // Set scaling to account for Retina display	
    if ([self respondsToSelector:@selector(setContentScaleFactor:)])
    {
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
    }
    
    // Get the layer
    CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
    
    eaglLayer.opaque = TRUE;
    eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
#if _ForceES1_
    _renderer = nil;
#else 
    _renderer = [[ES2Renderer alloc] init];
#endif
    
    if (!_renderer)
    {
        _renderer = [[ES1Renderer alloc] init];
        
        if (!_renderer)
        {
            result = NO;
        }
    }
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawView:)];
    [self startDisplayLink];

    return result;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        if (![self setup]) 
        {
            [self release];
        }
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder
{    
    if ((self = [super initWithCoder:coder])) 
    {	
        if (![self setup]) 
        {
            [self release];
        }
    }
    return self;
}

#pragma mark -
#pragma mark UIView layout methods

- (void)drawView:(id)sender
{
    [_renderer render];
}

- (void)layoutSubviews
{	
	NSLog(@"Scale factor: %f", self.contentScaleFactor);
    [_renderer resizeFromLayer:(CAEAGLLayer*)self.layer];
    [self drawView:nil];
}

#pragma mark -
#pragma mark Touch-handling methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event 
{
}

@end
