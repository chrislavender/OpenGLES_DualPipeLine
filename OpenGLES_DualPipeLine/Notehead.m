//
//  Notehead.m
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/5/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "Notehead.h"
#import "Staff.h"

@interface Notehead()
{
    const Vertex *_vertices;
    const GLuint *_indices;
    int numIndices; //taking in the number of vertices
}
@end

@implementation Notehead
@synthesize staff   = _staff;
@synthesize type    = _type;
@synthesize staffOffset  = _staffOffset;

@synthesize stemOffsetRight = _stemOffsetRight;
@synthesize stemOffsetLeft  = _stemOffsetLeft;

+ (Notehead *)noteheadOfType:(NoteheadType)type forStaff:(Staff *)staff atVerticalOffset:(NSInteger)vertOffset
{
    return [[[self alloc]initWithnoteheadType:type forStaff:staff atVerticalOffset:vertOffset]autorelease];
}

- (id)initWithnoteheadType:(NoteheadType)type forStaff:(Staff *)staff atVerticalOffset:(NSInteger)vertOffset
{
    if (self = [super init]) {
        
        self.drawLocation = Point3DMake(staff.drawLocation.x, 
                                          [staff yCoordinateForStaffOffset:vertOffset], 
                                           staff.drawLocation.z);
        _staff = staff;
        _type = type;
        _staffOffset = vertOffset;
        
        switch (_type) {
            case FILLED:
            {
                _vertices = notehead_filledVertices;
                _indices = notehead_filledIndices;
                numIndices = notehead_filledNumIndices;
                
                _stemOffsetRight = notehead_filledOffsetRight;
                _stemOffsetLeft  = notehead_filledOffsetLeft;
                
                break;
            }
            case HALF:
            {
                _vertices = notehead_halfVertices;
                _indices = notehead_halfIndices;
                numIndices = notehead_halfNumIndices;
                
                _stemOffsetRight = notehead_halfOffsetRight;
                _stemOffsetLeft  = notehead_halfOffsetLeft;
                
                break;
            }
            case WHOLE:
            {
                _vertices = notehead_wholeVertices;
                _indices = notehead_wholeIndices;
                numIndices = notehead_wholeNumIndices;
                break;
            }

            default:
                break;
        }
    }
    return self;
}

- (void)draw 
{
    glPushMatrix();
    glTranslatef(self.drawLocation.x, self.drawLocation.y, self.drawLocation.z);
    
    // glScalef(.5, .5, 0.0);
    
    glVertexPointer(3, GL_FLOAT, sizeof(Vertex), _vertices);                
    glColorPointer(4, GL_FLOAT, sizeof(Vertex), &_vertices->color.r);
    
    glDrawElements(GL_TRIANGLES, numIndices, GL_UNSIGNED_INT, _indices);
    glPopMatrix();

    [self.itemsToDraw makeObjectsPerformSelector:@selector(draw)];
}

@end
