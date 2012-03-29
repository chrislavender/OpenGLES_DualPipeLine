//
//  ES2Renderer.h
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 2/27/12.
//  Copyright (c) 2012 GnarlyDogMusic. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <QuartzCore/QuartzCore.h>

#import "RendererProtocol.h"

@interface ES2Renderer : NSObject <RendererProtocol>

- (void)render;
- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer;

@end