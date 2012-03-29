//
//  Clef.m
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/1/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "Clef.h"

#import "Staff.h"

@interface Clef()
{
    const Vertex *_vertices;
    const GLuint *_indices;
    GLsizei numIndices; //taking in the number of vertices
}
@end

@implementation Clef

- (void)dealloc
{
    
    [super dealloc];
}

+ (Clef *)clefOfType:(ClefType)type forStaff:(Staff *)staff atHorizontalOffset:(NSInteger)offset
{    
    return [[[self alloc]initWithType:type forStaff:staff atHorizontalOffset:offset] autorelease];
}


- (id)initWithType:(ClefType)type forStaff:(Staff *)staff atHorizontalOffset:(NSInteger)offset;

{
    if (self = [super init]) {

        self.drawLocation = Point3DMake(staff.drawLocation.x + offset, staff.centerY.y, staff.drawLocation.z);
        
        switch (type) {
            case TREBLECLEF:
            {
                _vertices = treble_clefVertices;
                _indices = treble_clefIndices;
                numIndices = treble_clefNumIndices;   //reading the number of vertices from the objects.h file.
                break;
            }
            case BASSCLEF:
            {
                _vertices = f_clefVertices;
                _indices = f_clefIndices;
                numIndices = f_clefNumIndices; //reading the number of vertices from the objects.h file.
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
    
    //glScalef(.5, .5, 0.0);

    glVertexPointer(3, GL_FLOAT, sizeof(Vertex), _vertices);                
    glColorPointer(4, GL_FLOAT, sizeof(Vertex), &_vertices->color.r);
    
    glDrawElements(GL_TRIANGLES, numIndices, GL_UNSIGNED_INT, _indices);
    
    glPopMatrix();

    [self.itemsToDraw makeObjectsPerformSelector:@selector(draw)];
}

@end
