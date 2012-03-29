//
//  Flag.h
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/8/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "GlyphBase.h"

@class Stem;

@interface Flag : GlyphBase

+ (Flag *)flagOfType:(FlagType)type forStem:(Stem *)stem;

- (id)initFlagOfType:(FlagType)type forStem:(Stem *)stem;
@end
