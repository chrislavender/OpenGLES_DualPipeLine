//
//  Notehead.h
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/5/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "GlyphBase.h"

@class Staff;

@interface Notehead : GlyphBase

@property (unsafe_unretained, nonatomic) Staff *staff;
@property NoteheadType type;
@property Point3D stemOffsetRight;
@property Point3D stemOffsetLeft;
@property NSInteger staffOffset;

// CL: noteheads do not know their final horizontal offset. That is determined by the stem they belong too.
+ (Notehead *)noteheadOfType:(NoteheadType)type 
                    forStaff:(Staff *)staff
            atVerticalOffset:(NSInteger)vertOffset;

@end
