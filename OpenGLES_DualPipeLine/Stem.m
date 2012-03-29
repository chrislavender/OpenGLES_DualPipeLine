//
//  Stem.m
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/5/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "Stem.h"

#import "Notehead.h"
#import "Staff.h"
#import "Flag.h"

#define _LINEWIDTH_ 3.0

@interface Stem()
{
    Vertex  _stemVerts[2];
    GLfloat xOffset;
}
@property (strong, nonatomic) Notehead  *originNote;
@property (strong, nonatomic) Notehead  *endNote;
@property (strong, nonatomic) NSArray   *notes;
@property (strong, nonatomic) Flag      *flag;
@end

@implementation Stem
@synthesize height              = _height;
@synthesize direction           = _direction;
@synthesize flagConnectionPoint = _flagConnectionPoint;

@synthesize notes       = _notes;
@synthesize originNote  = _originNote; //CL: the note at the base of the stem
@synthesize endNote     = _endNote; //CL: if multiple notes, the farthest one from the origin note (closest to flag)
@synthesize flag        = _flag;

- (void)dealloc
{
    [_notes         release];
    [_originNote    release];
    [_endNote       release];
    [_flag          release];
    
    [super dealloc];
}

- (void)setXOffsetForNote:(Notehead *)note usingAdditionShift:(GLfloat)shift2nds
{
    if (_direction == DOWN) 
    {
        shift2nds = shift2nds * -1;
    }
    note.drawLocation = Point3DMake(xOffset + shift2nds, note.drawLocation.y, note.drawLocation.z);
}

- (void)handleMultipleNotes
{
    NSInteger lastNoteStaffOffset = 0;

    for (Notehead *note in self.notes)
    {
        // CL: set the x offset for any notes that are a second apart.
        GLfloat shift2nds = 0;
        if (note.staffOffset - lastNoteStaffOffset == 1) 
        {
            shift2nds = note.stemOffsetRight.x - note.stemOffsetLeft.x - _LINEWIDTH_;
        }
        [self setXOffsetForNote:note usingAdditionShift:shift2nds];

        // CL: find the origin note and end note for the stem to draw from and to
        if (note.staffOffset <= self.originNote.staffOffset) 
        {
            self.originNote = note;
        }
        else if (note.staffOffset >= self.endNote.staffOffset) 
        {
            self.endNote = note;
        }
        
        lastNoteStaffOffset = note.staffOffset;
    }
    
    //CL: Adjust height for multiple notes
    _height =  self.originNote.drawLocation.y - self.endNote.drawLocation.y;
        
    // CL: if the direction is down then swap them
    if (_direction == DOWN) {
        Notehead *placeHolder = [_endNote retain];
        self.endNote = self.originNote;
        self.originNote = placeHolder;
        [placeHolder release];
    }
}

- (void)setupAtXOffset:(GLfloat)horOffset 
           inDirection:(StemDirection)direction 
          withFlagType:(FlagType)type;
{
    xOffset = horOffset;
    _direction = direction;

    // CL: if there is more than one note in the array than setup for multiple notes
    if ([self.notes count] > 1) 
    {
        [self handleMultipleNotes];
    }
    else 
    {
        // CL: else if the array has one note make that the origin note
        if (self.notes != nil) self.originNote = [self.notes objectAtIndex:0];
        // CL: set the origin note's x offset
        self.originNote.drawLocation = Point3DMake(xOffset, self.originNote.drawLocation.y, self.originNote.drawLocation.z);
    }
    
    self.drawLocation = Point3DMake(horOffset, self.originNote.drawLocation.y, self.originNote.drawLocation.z);
    
    // CL: figure out the base height of the stem given a staff's spacing
    int spacing = self.originNote.staff.offsetSpacing;
    _height = _height + spacing * 7;
    
    // CL: if the direction should be up than invert he height
    if (direction == UP) _height = _height * -1;
    
    [self makeStemInDirection:direction];
    
    if (type != NOFLAG) 
    {
        // CL: if this stem needs a flag add it now that it has vertices and a flagConnectionPoint
        Flag *flag = [[Flag alloc]initFlagOfType:type forStem:self];
         NSMutableArray *tempDrawItems = [[NSMutableArray alloc] initWithArray:self.itemsToDraw];
         [tempDrawItems addObject:flag];
         self.itemsToDraw = tempDrawItems;
         [tempDrawItems release];
    }
}

- (id)initWithNotes:(NSArray *)notes 
      withDirection:(StemDirection)direction 
        andFlagType:(FlagType)type 
 atHorizontalOffset:(GLfloat)horOffset

{
    if (self = [super init]) 
    {
        self.itemsToDraw = notes;
        self.notes = notes;
        [self setupAtXOffset:horOffset inDirection:direction withFlagType:type];
    }
    return self;
}

+ (Stem *)stemForNotes:(NSArray *)notes 
         withDirection:(StemDirection)direction 
           andFlagType:(FlagType)type 
    atHorizontalOffset:(GLfloat)horOffset;
{
    return [[[self alloc]initWithNotes:(NSArray *)notes withDirection:direction andFlagType:type atHorizontalOffset:horOffset] autorelease];
}

- (id)initWithNote:(Notehead *)note 
     withDirection:(StemDirection)direction 
       andFlagType:(FlagType)type 
atHorizontalOffset:(GLfloat)horOffset
{
    if (self = [super init]) 
    {
        self.itemsToDraw = [NSArray arrayWithObject:note];
        self.originNote = note;
        [self setupAtXOffset:horOffset inDirection:direction withFlagType:type];
    }    
    return self;
}

+ (Stem *)stemForNote:(Notehead *)note 
        withDirection:(StemDirection)direction 
          andFlagType:(FlagType)type 
   atHorizontalOffset:(GLfloat)horOffset
{
    return [[[self alloc]initWithNote:(Notehead *)note withDirection:direction andFlagType:type atHorizontalOffset:horOffset] autorelease];
}


- (void)makeStemInDirection:(StemDirection)direction
{   
    if (_direction) 
    {
        Point3D offset = Point3DMake(0.0, 0.0, 0.0);
        
        if (direction == DOWN) {
            offset.x = self.originNote.stemOffsetLeft.x + (_LINEWIDTH_ * .5);
            offset.y = self.originNote.stemOffsetLeft.y;
            offset.z = self.originNote.stemOffsetLeft.z;
        }
        else if (direction == UP)
        {
            offset.x = self.originNote.stemOffsetRight.x - (_LINEWIDTH_ * .5);
            offset.y = self.originNote.stemOffsetRight.y;
            offset.z = self.originNote.stemOffsetRight.z;
        }
        _stemVerts[0] = VertexMake(offset.x, offset.y, offset.z, 0.0f, 0.0f, 0.0f, 1.0f);
        _stemVerts[1] = VertexMake(offset.x, offset.y + _height, offset.z, 0.0f, 0.0f, 0.0f, 1.0f);
        
        _flagConnectionPoint = Point3DMake(_stemVerts[1].position.x, _stemVerts[1].position.y, _stemVerts[1].position.z);
    }
}


- (void)draw 
{    
    glPushMatrix();
    
    glTranslatef(self.drawLocation.x, self.drawLocation.y, self.drawLocation.z);
    
    //glScalef(.5, .5, 0.0);
    
    glVertexPointer(3, GL_FLOAT, sizeof(Vertex), _stemVerts);
    glColorPointer(4, GL_FLOAT, sizeof(Vertex), &_stemVerts->color.r);
    
    glLineWidth(_LINEWIDTH_);
    glDrawArrays(GL_LINES, 0, 2);

    glPopMatrix();

    [self.itemsToDraw makeObjectsPerformSelector:@selector(draw)];
}

@end
