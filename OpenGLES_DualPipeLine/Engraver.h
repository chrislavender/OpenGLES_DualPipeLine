//
//  Engraver.h
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/1/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Engraver, Page;
@protocol EngraverDelegate <NSObject>
- (void)sendObjectsToEAGLView:(NSArray *)openGLTree;
@end

@interface Engraver : NSObject

@property (unsafe_unretained, nonatomic) id<EngraverDelegate> delegate;

@property CGRect currentFrame;
@property NSInteger numStavesPerLine;

- (void)engrave;

@end
