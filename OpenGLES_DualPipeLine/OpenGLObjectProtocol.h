//
//  OpenGLObjectProtocol.h
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 2/28/12.
//  Copyright (c) 2012 GnarlyDogMusic. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "objects.h"

@protocol OpenGLObjectProtocol <NSObject>

@property (strong, nonatomic) NSArray *itemsToDraw;

- (void)draw;
@end
