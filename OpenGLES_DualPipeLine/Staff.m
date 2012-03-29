//
//  Staff.m
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/1/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "Staff.h"

@interface Staff()
{
    Vertex  *_staffVerts;
    GLuint  _numVertices;
    Point3D _origin;
}
@end

@implementation Staff
@synthesize offsetSpacing   = _offsetSpacing;
@synthesize centerY         = _centerY;
- (void)dealloc
{
    free(_staffVerts);
    
    [super dealloc];
}

+ (Staff *)staffWithNumberOfLines:(NSNumber *)numberOfLines andSpacing:(NSNumber *)spacing forFrame:(CGRect)frame atLocation:(Point3D)point
{
    return [[[self alloc]initWithNumberOfLines:numberOfLines andSpacing:spacing forFrame:frame atLocation:point] autorelease];
}

- (id)initWithNumberOfLines:(NSNumber *)numberOfLines andSpacing:(NSNumber *)spacing forFrame:(CGRect)frame atLocation:(Point3D)point
{
    if (self = [super init]) {
        _origin         = point;
        _numVertices    = [numberOfLines intValue] * 2;
        _staffVerts     = malloc(sizeof(Vertex) * _numVertices);

        [self makeStaffWithNumLines:[numberOfLines intValue] andSpacing:[spacing intValue] forFrame:frame atPoint:point];
    }
    return self;
}

- (void)makeStaffWithNumLines:(GLuint)numLines andSpacing:(GLuint)spacing forFrame:(CGRect)frame atPoint:(Point3D)point
{    
    _offsetSpacing = spacing * .5;
    
    int xBegin = (frame.origin.x + 40) + point.x;
    int xEnd = (frame.size.width - 40) - point.x;
    
    int y = (frame.origin.y + 30) + point.y;
    
    for (int i = 0; i < numLines; ++i) {
        int offset = spacing * i;
        
        int row = i * 2;
        
        _staffVerts[row] = VertexMake(xBegin, y + offset, 0.0, 0.0f, 0.0f, 0.0f, 1.0f);
        _staffVerts[row + 1] = VertexMake(xEnd, y + offset, 0.0, 0.0f, 0.0f, 0.0f, 1.0f);
    }
    
    // CL: find the "center" location (line or space)
    if (numLines % 2 == 0) 
    {
        // CL: two verts per line so find middle line's left vert
        int centerIndex = _numVertices * .5;
        
        _centerY = Point3DMake(_staffVerts[centerIndex].position.x, 
                               _staffVerts[centerIndex].position.y - (spacing * .5), // CL: and subtract half the spacing
                               _staffVerts[centerIndex].position.z);

    }
    else
    {
        // CL: subtract the verts for one line and divide by 2 to get the left vert of the center line.
        int centerIndex = (_numVertices - 2) * .5;
        _centerY = Point3DMake(_staffVerts[centerIndex].position.x, 
                               _staffVerts[centerIndex].position.y, 
                               _staffVerts[centerIndex].position.z);
    }
    
//    for (int k = 0; k < numLines*2; ++k) {
//        float x = staffVerts[k].position[0];
//        float y = staffVerts[k].position[1];
//        
//        printf("%f, %f\n", x, y);
//    }
}

- (CGFloat)yCoordinateForStaffOffset:(GLint)staffOffset
{
    CGFloat coord = 0;
    
    coord = _offsetSpacing * staffOffset * -1 + _centerY.y;
    
    return coord;
}

- (void)draw 
{    
    glPushMatrix();
    
    glTranslatef(_origin.x, _origin.y, _origin.z);
    
    glVertexPointer(3, GL_FLOAT, sizeof(Vertex), _staffVerts);
    glColorPointer(4, GL_FLOAT, sizeof(Vertex), &_staffVerts->color.r);
    
    GLsizei vertexCount = _numVertices;
    glLineWidth(1.0);
    glDrawArrays(GL_LINES, 0, vertexCount);
    
    [self.itemsToDraw makeObjectsPerformSelector:@selector(draw)];
    
    glPopMatrix();
}

@end
