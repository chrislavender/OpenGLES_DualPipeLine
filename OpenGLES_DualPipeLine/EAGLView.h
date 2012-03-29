//
//  EAGLView.h
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 2/27/12.
//  Copyright (c) 2012 GnarlyDogMusic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "RendererProtocol.h"

@interface EAGLView : UIView

@property (strong, nonatomic) id <RendererProtocol> renderer;

- (void)drawView:(id)sender;
- (void)startDisplayLink;
- (void)stopDisplayLink;
@end
