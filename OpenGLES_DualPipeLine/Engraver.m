//
//  Engraver.m
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/1/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "Engraver.h"

#import "objects.h"

#import "Page.h"
#import "Line.h"
#import "Staff.h"
#import "Clef.h"
#import "NoteHead.h"
#import "Stem.h"

@interface Engraver()
{
    Page *_currentPage;
}

@end

@implementation Engraver
@synthesize delegate;
@synthesize currentFrame = _currentFrame;
@synthesize numStavesPerLine = _numStavesPerLine;

- (void)engrave
{    
    // CL: create some staffs
    Staff *trebleStaff = [Staff staffWithNumberOfLines:[NSNumber numberWithInt:5] 
                                            andSpacing:[NSNumber numberWithInt:20]
                                              forFrame:self.currentFrame 
                                            atLocation:Point3DMake(0.0, 0.0, 0.0)];
    
    Staff *bassStaff = [Staff staffWithNumberOfLines:[NSNumber numberWithInt:5] 
                                          andSpacing:[NSNumber numberWithInt:20]
                                            forFrame:self.currentFrame 
                                          atLocation:Point3DMake(0.0, 80.0, 0.0)]; 
    
    // CL: create some clefs, set their anchor location and put them on the staffs
    Clef *trebleClef = [Clef clefOfType:TREBLECLEF forStaff:trebleStaff atHorizontalOffset:70];
    Clef *bassClef = [Clef clefOfType:BASSCLEF forStaff:bassStaff atHorizontalOffset:70];
    
    Notehead *note1a = [Notehead noteheadOfType:FILLED forStaff:trebleStaff atVerticalOffset:-3];
    Notehead *note1b = [Notehead noteheadOfType:FILLED forStaff:trebleStaff atVerticalOffset:-2];
    Notehead *note1c = [Notehead noteheadOfType:FILLED forStaff:trebleStaff atVerticalOffset:0];
    Notehead *note1d = [Notehead noteheadOfType:FILLED forStaff:trebleStaff atVerticalOffset:1];

    Notehead *note2 = [Notehead noteheadOfType:HALF forStaff:trebleStaff atVerticalOffset:-3];
    Notehead *note3 = [Notehead noteheadOfType:WHOLE forStaff:trebleStaff atVerticalOffset:-3];
    
    Stem *stem1 = [Stem stemForNotes:[NSArray arrayWithObjects:note1a,note1b,note1c, note1d,nil] 
                       withDirection:UP 
                   andFlagType:EIGHTH
                  atHorizontalOffset:150.0];
    
    Stem *stem2 = [Stem stemForNote:note2 
                      withDirection:UP 
                        andFlagType:NOFLAG
                 atHorizontalOffset:200.0];
    
    Stem *stem3 = [Stem stemForNote:note3 
                      withDirection:NOSTEM 
                        andFlagType:NOFLAG
                 atHorizontalOffset:300.0];
        
    NSArray *staffItems1 = [NSArray arrayWithObjects:trebleClef, stem1, stem2,stem3, nil];
    trebleStaff.itemsToDraw = staffItems1;
    
    NSArray *staffItems2 = [NSArray arrayWithObject:bassClef];
    bassStaff.itemsToDraw = staffItems2;
    
    // CL: create some lines, set their anchor locations, give them their staffs
    Line *line1 = [Line line];
    line1.drawLocation = Point3DMake(0.0, 20.0, 0.0);
    Line *line2 = [Line line];
    line2.drawLocation = Point3DMake(0.0, 350.0, 0.0);
    
    //Line *line3 = [Line line];
    //line3.drawLocation = Point3DMake(0.0, 400.0, 0.0);

    NSArray *staves = [NSArray arrayWithObjects:trebleStaff,bassStaff, nil];
    line1.itemsToDraw = staves;
    line2.itemsToDraw = staves;
    //line3.itemsToDraw = staves;
    
    // CL: create a page and give it it's lines
    _currentPage = [Page pageForFrame:self.currentFrame];
    NSArray *lines = [NSArray arrayWithObjects:line1,line2, nil];
    _currentPage.itemsToDraw = lines;
    
    NSArray *pagesArray = [NSArray arrayWithObject:_currentPage];
    
    [self.delegate sendObjectsToEAGLView:pagesArray];
}


@end
