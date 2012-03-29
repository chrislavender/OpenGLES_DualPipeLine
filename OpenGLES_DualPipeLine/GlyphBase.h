//
//  GlyphBase.h
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/1/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGlES/ES2/glext.h>

#import "objects.h"

@interface GlyphBase : NSObject

@property (copy, nonatomic) NSArray *itemsToDraw;
@property (copy, nonatomic) NSData  *drawData;

@property Point3D drawLocation;

- (void)draw;

@end
