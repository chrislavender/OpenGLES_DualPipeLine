//
//  Clef.h
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/1/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlyphBase.h"

@class Staff;
@interface Clef : GlyphBase

+ (Clef *)clefOfType:(ClefType)type 
            forStaff:(Staff *)staff 
  atHorizontalOffset:(NSInteger)offset;

@end
