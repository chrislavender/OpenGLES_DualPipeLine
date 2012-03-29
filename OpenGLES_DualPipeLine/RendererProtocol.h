//
//  RendererProtocol.h
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 2/27/12.
//  Copyright (c) 2012 GnarlyDogMusic. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>

@protocol RendererProtocol <NSObject>

@property (strong, nonatomic) NSArray *thingsToDraw;

@property GLint backingWidth;
@property GLint backingHeight;// The pixel dimensions of the CAEAGLLayer

- (void)render;
- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer;

@end