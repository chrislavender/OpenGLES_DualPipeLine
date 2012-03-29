//
//  ViewController.h
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 2/27/12.
//  Copyright (c) 2012 GnarlyDogMusic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Engraver.h"

@class EAGLView;
@interface ViewController : UIViewController <EngraverDelegate>

@property (strong, nonatomic) IBOutlet EAGLView *glView;

@end
