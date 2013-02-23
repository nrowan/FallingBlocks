//
//  Piece.m
//  myFallingBlocks
//
//  Created by Nate Rowan on 2/13/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "Piece.h"
#import "BlockFactory.h"

@implementation Piece
@synthesize row = _row;
@synthesize column = _column;
@synthesize pieceOrientations = _pieceOrientations;
@synthesize pieceDropEvery = _pieceDropEvery;
@synthesize pieceDropEveryDefault = _pieceDropEveryDefault;
@synthesize pieceTimeSinceLastMoved = _pieceTimeSinceLastMoved;
@synthesize blockFactory = _blockFactory;

- (id) init: (NSTimeInterval) speed blockFactory: (BlockFactory *) blockFactory
{
    self.blockFactory = blockFactory;
    // Random start orientation for the new piece
    int r = arc4random_uniform(4);
    self.orientation = r;
    // Store orientations in an array for quick access
    self.pieceOrientations = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++) {
        self.pieceOrientations[i] = [self getOrientation:i];
    }
    
    self.pieceTimeSinceLastMoved = 0;
    self.pieceDropEveryDefault = speed;
    
    self.pieceDropEvery = self.pieceDropEveryDefault;
    
    return self;
}

// Set the top left position of this piece. Most likely decided based on where it needs to start and how many rows the piece has
- (void) setPosition:(NSInteger) row column: (NSInteger) column
{
    self.row = row;
    self.column = column;
}

// Return the piece according to the current orientation
- (NSMutableArray *) getPieceArray
{
    return self.pieceOrientations[self.orientation];
}

- (BOOL) isNorth: (NSInteger) passedOrientation
{
    return passedOrientation == 0;
}

- (BOOL) isEast: (NSInteger) passedOrientation
{
    return passedOrientation == 1;
}

- (BOOL) isSouth: (NSInteger) passedOrientation
{
    return passedOrientation == 2;
}

- (BOOL) isWest: (NSInteger) passedOrientation
{
    return passedOrientation == 3;
}

// Rotate the piece to the next orientation
- (void) rotate
{
    if(self.orientation == 3)
        self.orientation = 0;
    else
        self.orientation++;
}

// Unrotate the piece to the previous orientation
- (void) unrotate
{
    if(self.orientation == 0)
        self.orientation = 3;
    else
        self.orientation--;
}

- (void) drop
{
    double speedToIncrease = 0.4;
    self.pieceDropEvery = self.pieceDropEvery * speedToIncrease;
}

// Should be overidden by the subclass with the piece's 4 orientations
- (NSMutableArray *) getOrientation: (NSInteger) orientation
{
    return NULL;
}

@end
