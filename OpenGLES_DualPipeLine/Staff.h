//
//  Staff.h
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/1/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlyphBase.h"

@interface Staff : GlyphBase

@property GLint offsetSpacing; // CL: represents the spacing between a line and a space's center.
@property Point3D centerY;

+ (Staff *)staffWithNumberOfLines:(NSNumber *)numberOfLines 
                       andSpacing:(NSNumber *)spacing
                         forFrame:(CGRect)frame 
                       atLocation:(Point3D)point;

// CL: method that returns a y pixel coordinate for a given staff integer offset
- (CGFloat)yCoordinateForStaffOffset:(GLint)staffOffset;

@end