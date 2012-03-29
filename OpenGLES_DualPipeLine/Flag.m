//
//  Flag.m
//  OpenGLES_DualPipeLine
//
//  Created by Chris Lavender on 3/8/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "Flag.h"
#import "Stem.h"

@interface Flag()
{
    const Vertex *_vertices;
    const GLuint *_indices;
    int numIndices; //taking in the number of vertices
    
    StemDirection direction;
}
@end

@implementation Flag

- (id)initFlagOfType:(FlagType)type forStem:(Stem *)stem
{
    if (self = [super init]) 
    {
        direction = stem.direction;
        
        self.drawLocation = Point3DMake(stem.drawLocation.x + stem.flagConnectionPoint.x, //CL: subtract the flagConnection
                                        stem.drawLocation.y + stem.flagConnectionPoint.y, 
                                        stem.drawLocation.z);
        switch (type) 
        {
            case EIGHTH:
            {
                _vertices = flag_eighthVertices;
                _indices = flag_eighthIndices;
                numIndices = flag_eighthNumIndices;
                break;
            }
            case SIXTEENTH:
            {
                _vertices = notehead_halfVertices;
                _indices = notehead_halfIndices;
                numIndices = notehead_halfNumIndices;
                break;
            }
            case THIRTYSECOND:
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

+ (Flag *)flagOfType:(FlagType)type forStem:(Stem *)stem
{
    return [[[self alloc]initFlagOfType:type forStem:stem] autorelease];
}

- (void)draw 
{    
    glPushMatrix();
    glTranslatef(self.drawLocation.x, self.drawLocation.y, self.drawLocation.z);
    
    if (direction == DOWN) glRotatef(180.0, 1.0, 0.0, 0.0);
    //glScalef(.5, .5, 0.0);
    
    glVertexPointer(3, GL_FLOAT, sizeof(Vertex), _vertices);                
    glColorPointer(4, GL_FLOAT, sizeof(Vertex), &_vertices->color.r);
    
    glDrawElements(GL_TRIANGLES, numIndices, GL_UNSIGNED_INT, _indices);
    
    glPopMatrix();
}
@end
