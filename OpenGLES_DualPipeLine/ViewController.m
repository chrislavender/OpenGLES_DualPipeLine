//
//  ViewController.m
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 2/27/12.
//  Copyright (c) 2012 GnarlyDogMusic. All rights reserved.
//

#import "ViewController.h"

#import "EAGLView.h"
#import "RendererProtocol.h"

#import "Engraver.h"

@interface ViewController ()
{
    Engraver *_engraver;
}
@end

@implementation ViewController
@synthesize glView = _glView;

- (void)dealloc 
{
    [_engraver  release];
    [_glView    release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _engraver = [[Engraver alloc]init];
    _engraver.currentFrame = CGRectMake(self.glView.bounds.origin.x,
                                        self.glView.bounds.origin.y, 
                                        self.glView.renderer.backingWidth , 
                                        self.glView.renderer.backingHeight);
    _engraver.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
                                         duration:(NSTimeInterval)duration
{
    _engraver.currentFrame = CGRectMake(self.glView.bounds.origin.x,
                                        self.glView.bounds.origin.y, 
                                        self.glView.renderer.backingWidth , 
                                        self.glView.renderer.backingHeight);
    [_engraver engrave];
}

- (void)sendObjectsToEAGLView:(NSArray *)openGLTree {
    self.glView.renderer.thingsToDraw = openGLTree;
}

- (IBAction)makeThing:(id)sender {
    
    [_engraver engrave];
        
    
//    GLViewLayer1 *newShit = [[GLViewLayer1 alloc]init];
//    GLViewLayer2 *additionalNewShit = [[GLViewLayer2 alloc]init];
//    
//    NSArray *things = [NSArray arrayWithObjects:newShit, nil];
//    
//    self.glView.renderer.drawTree = things;
}
@end
