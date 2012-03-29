//
//  Stem.h
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/5/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "GlyphBase.h"

@class Notehead;

@interface Stem : GlyphBase

@property GLfloat height;
@property StemDirection direction;
@property Point3D flagConnectionPoint;

// CL: stems do not have a vertical offset. That is determined by the note (or notes) it has.
+ (Stem *)stemForNotes:(NSArray *)notes 
         withDirection:(StemDirection)direction
           andFlagType:(FlagType)type
    atHorizontalOffset:(GLfloat)horOffset;

+ (Stem *)stemForNote:(Notehead *)note 
        withDirection:(StemDirection)direction
          andFlagType:(FlagType)type
   atHorizontalOffset:(GLfloat)horOffset;

@end
