//
//  FallingBlocks.m
//  FallingBlocks
//
//  Created by Nate Rowan on 2/10/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "FallingBlocks.h"
#import "Piece.h"
#import "Square.h"
#import "Line.h"
#import "Jagged.h"
#import "JaggedBackwards.h"
#import "Cross.h"
#import "L.h"
#import "LBackwards.h"
#import "Block.h"
#import "BlockFactory.h"

@implementation FallingBlocks

@synthesize score = _score;
@synthesize level = _level;
@synthesize gameArray = _gameArray;
@synthesize fallingPiece = _fallingPiece;
@synthesize levelDetails = _levelDetails;
@synthesize blockFactory = _blockFactory;

const double TOTAL_LEVELS = 50;
const NSInteger SCORE_MULTIPLIER = 1;

// The board is 4 rows bigger to account for the block starting off screen
const NSInteger BOARD_ROWS = 24;
const NSInteger BOARD_ROWS_VISIBLE = 20;
const NSInteger BOARD_COLS = 10;

const NSInteger START_PIECE_ROW = 4;
const NSInteger START_PIECE_COLUMN = 4;

-(id) init: (BlockFactory *) blockFactory
{
    self.level = 1;
    self.score = 0;
    self.blockFactory = blockFactory;
    
    // Speed decrease for each level averaged over total levels
    double levelSpeedDecrease = 60.0 / (TOTAL_LEVELS-1.0);
    NSMutableArray *levelColumn;
    self.levelDetails = [[NSMutableArray alloc] init];
    double tempSpeed;
    
    // Set how many 4 row combos it would take to move to next level
    NSInteger numberOfMaxRowsToCompleteLevel = 10;
    
    // Set the array for the different level settings
    for (int i = 0; i < TOTAL_LEVELS; i++) {
        levelColumn = [[NSMutableArray alloc] init];
        // Add speed based on the level
        tempSpeed = (60.0 - (levelSpeedDecrease * i)) / 60.0;
        [levelColumn addObject:[NSNumber numberWithDouble:tempSpeed]];
        
        // Non complete equation for the score required to reach the next level. Current max rows is equal to 16.
        // This is terrible but I'm tired
        [levelColumn addObject:[NSNumber numberWithInt:((i+1)*16*numberOfMaxRowsToCompleteLevel)*SCORE_MULTIPLIER]];

        [self.levelDetails addObject:levelColumn];
    }
    
    // Create the game board with all cells filled with nothing in them
    self.gameArray = [[NSMutableArray alloc] init];
    NSMutableArray *subArray;
    for(int i=0; i < BOARD_ROWS; i++) {
        subArray = [[NSMutableArray alloc] init];
        for (int j=0; j < BOARD_COLS; j++) {
            Block *newBlock = [self.blockFactory blockForKey:@""];
            [subArray addObject:newBlock];
        }
        [self.gameArray addObject:subArray];
    }
    
    return self;
}

- (NSInteger) fallingBlocksRenderRows
{
    return BOARD_ROWS_VISIBLE;
}

- (NSInteger) fallingBlocksRenderColumns
{
    return BOARD_COLS;
}

// Create new falling piece
- (void) newPiece
{
    double pieceSpeed = [[[self.levelDetails objectAtIndex:self.level-1] objectAtIndex:0 ] doubleValue];
    
    // Randomize the new piece that is created
    int r = arc4random_uniform(7);
    if(r == 0)
        self.fallingPiece = [[Square alloc] init:pieceSpeed blockFactory:self.blockFactory];
    else if(r == 1)
        self.fallingPiece = [[Line alloc] init:pieceSpeed blockFactory:self.blockFactory];
    else if(r == 2)
        self.fallingPiece = [[Jagged alloc] init:pieceSpeed blockFactory:self.blockFactory];
    else if(r == 3)
        self.fallingPiece = [[Cross alloc] init:pieceSpeed blockFactory:self.blockFactory];
    else if(r == 4)
        self.fallingPiece = [[L alloc] init:pieceSpeed blockFactory:self.blockFactory];
    else if(r == 5)
        self.fallingPiece = [[JaggedBackwards alloc] init:pieceSpeed blockFactory:self.blockFactory];
    else if(r == 6)
        self.fallingPiece = [[LBackwards alloc] init:pieceSpeed blockFactory:self.blockFactory];
    
    // Set the falling piece's starting upper left corner based on where the first visible row is and how many rows the piece is 
    NSInteger startRow = START_PIECE_ROW - ([self.fallingPiece.getPieceArray count] - 1);
    [self.fallingPiece setPosition:startRow column:START_PIECE_COLUMN];
}

// Advance the game by moving the falling piece down one row
- (BOOL) advanceGame:(NSTimeInterval) deltatime
{
    if(self.fallingPiece)
    {
        // Check to see when the piece last moved and if it should move again based on speed
        if([self shouldPieceMove:self.fallingPiece deltaTime:deltatime])
        {
            // Keep old location of of piece then move it
            NSInteger oldRowLocation = self.fallingPiece.row;
            self.fallingPiece.row++;
     
            // If the falling piece can't move then return it to previous location and save it to the board
            if(![self canPieceMove:self.fallingPiece])
            {
                self.fallingPiece.row = oldRowLocation;
                [self savePieceToArray:self.fallingPiece arrayToSavePiece:self.gameArray arrayRow:self.fallingPiece.row arrayColumn:self.fallingPiece.column];
                [self rowFilled];
                [self newLevel];
                
                // Create new piece, if new piece is immediately in a space it's not supposed to be, then game is over
                [self newPiece];
                if (![self canPieceMove:self.fallingPiece]) {
                    return FALSE;
                }
            }
        }
    }
    else
        [self newPiece];
    
    return TRUE;
}

// Return whether the piece should move on this frame
- (BOOL) shouldPieceMove: (Piece *) piece deltaTime: (NSTimeInterval) deltaTime
{
    if(piece.pieceTimeSinceLastMoved >= piece.pieceDropEvery)
    {
        piece.pieceTimeSinceLastMoved = 0;
        return TRUE;
    }
    else
    {
        piece.pieceTimeSinceLastMoved += deltaTime;
        return FALSE;
    }
}

- (void) newLevel
{
    // Increase level if score is greater than current level's max points required
    if(self.score >= [[[self.levelDetails objectAtIndex:self.level-1] objectAtIndex:1] integerValue] && self.level <= TOTAL_LEVELS)
        self.level++;
}

// Move the falling piece left or right one column
- (void) moveHorizontal:(NSString *)direction
{
    // Only move if there is a falling piece
    if(self.fallingPiece)
    {
        NSInteger oldColumnLocation = self.fallingPiece.column;
        
        if([direction isEqualToString:@"left"])
            self.fallingPiece.column--;
        else
            self.fallingPiece.column++;
        
        // If the falling piece can't move put it  back in it's previous location
        if(![self canPieceMove:self.fallingPiece])
            self.fallingPiece.column = oldColumnLocation;
    }
}

// Rotate the falling piece
- (void) rotate
{
    if(self.fallingPiece)
    {
        [self.fallingPiece rotate];
        
        // If the falling piece can't move then return it to previous location and save it to the board
        if(![self canPieceMove:self.fallingPiece])
        {
            [self.fallingPiece unrotate];
        }
    }
}

- (void) drop
{
    if(self.fallingPiece)
        [self.fallingPiece drop];
}

// Return an array that has all of the game contents on it
- (NSMutableArray *) gameDisplayArray
{
    // Copy game board into a new game board with just the visible parts and add the falling piece
    NSMutableArray *visibleGameArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *subArray;
    for(int i=(BOARD_ROWS - BOARD_ROWS_VISIBLE); i < BOARD_ROWS; i++) {
        subArray = [[NSMutableArray alloc] init];
        for (int j=0; j < BOARD_COLS; j++) {
            [subArray addObject:[[self.gameArray objectAtIndex:i] objectAtIndex:j]];
        }
        [visibleGameArray addObject:subArray];
    }
    
    // If the falling piece exists add it to the visible array being returned
    if(self.fallingPiece)
    {
        NSInteger visibleGameArrayRow = self.fallingPiece.row - (BOARD_ROWS - BOARD_ROWS_VISIBLE);
        [self savePieceToArray:self.fallingPiece arrayToSavePiece:visibleGameArray arrayRow:visibleGameArrayRow arrayColumn:self.fallingPiece.column];
    }
    
    return visibleGameArray;
}

// This method will save the currentPiece to the arrayToSavePiece in the location starting with (arrayRow, arrayColumn) for the top left corner
- (void) savePieceToArray: (Piece *) currentPiece arrayToSavePiece:(NSMutableArray *) arrayToSavePiece arrayRow: (NSInteger) arrayRow arrayColumn: (NSInteger) arrayColumn
{
    NSInteger pieceRows = currentPiece.getPieceArray.count;
    NSInteger pieceColumns = [[currentPiece.getPieceArray objectAtIndex:0] count];
    Block *currentBlock;
    NSInteger passedArrayRow;
    NSInteger passedArrayColumn;
    
    for (int i = 0; i < pieceRows; i++) {
        for (int j = 0; j < pieceColumns; j++) {
            // Get the row and column in the passed array for the falling piece's current block
            passedArrayRow = i + arrayRow;
            passedArrayColumn = j + arrayColumn;
            
            // If the row falls outside the array then ignore it
            if(passedArrayRow >= 0)
            {
                // Find the value of the current block
                currentBlock = [[currentPiece.getPieceArray objectAtIndex:i] objectAtIndex:j];
                
                // Save current block in the game board if has a value
                if([currentBlock blockExist])
                {
                    [[arrayToSavePiece objectAtIndex:passedArrayRow] replaceObjectAtIndex:passedArrayColumn withObject:currentBlock];
                }
            }
        }
    }
}

// Using collision and board boundaries check if the falling piece can move to location that has been set for it
- (BOOL) canPieceMove: (Piece *) currentPiece
{
    // Find falling piece dimensions
    NSInteger pieceRows = currentPiece.getPieceArray.count;
    NSInteger pieceColumns = [[currentPiece.getPieceArray objectAtIndex:0] count];
    
    Block *currentBlock;
    NSInteger gameArrayRow;
    NSInteger gameArrayColumn;
    
    for (int i = 0; i < pieceRows; i++) {
        for (int j = 0; j < pieceColumns; j++) {
            // Get the row and column in the game array for the falling piece's current block
            gameArrayRow = i + currentPiece.row;
            gameArrayColumn = j + currentPiece.column;
            
            // Get whether current location in the piece has a block
            currentBlock = [[currentPiece.getPieceArray objectAtIndex:i] objectAtIndex:j];
            
            // If there is a collision return false
            if([currentBlock blockExist] && [self collision:gameArrayRow column:gameArrayColumn])
            {
                return false;
            }
        }
    }
    
    return true;
}

// Check if any rows got completed, if so remove them and add up the score
- (void) rowFilled
{
    NSInteger completedRows = 0;
    NSInteger tempValue = 0;
    Block *tempBlock;
    for (int i = 0; i < BOARD_ROWS; i++) {
        for (int j=0; j < BOARD_COLS; j++) {
            tempBlock = [[self.gameArray objectAtIndex:i] objectAtIndex:j];
            if([tempBlock blockExist])
                tempValue++;
        }
        // If the number of columns that have a block in them equals total number of columns, the row is complete
        if(tempValue == BOARD_COLS)
        {
            self.gameArray = [self replaceCompletedRow:self.gameArray row:i];
            completedRows++;
        }
        tempValue = 0;
    }
    [self addScore:completedRows];
}

// Function to handle scoring
- (void) addScore:(NSInteger) numberOfLines;
{
    for (int i = 1; i < numberOfLines+1; i++) {
        self.score += (i*i)*SCORE_MULTIPLIER;
    }
}

// Remove the row from array and insert new empty row at beginning
- (NSMutableArray *) replaceCompletedRow: (NSMutableArray *) passedArray row: (NSInteger) row
{
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    
    // Copy all but the passed row to a new array
    NSMutableArray *subArray;
    for(int i=0; i < BOARD_ROWS; i++) {
        if(i != row)
        {
            subArray = [[NSMutableArray alloc] init];
            for (int j=0; j < BOARD_COLS; j++) {
                [subArray addObject:[[passedArray objectAtIndex:i] objectAtIndex:j]];
            }
            
            [newArray addObject:subArray];
        }
    }

    subArray = [[NSMutableArray alloc] init];
    for (int j=0; j < BOARD_COLS; j++) {
        Block *newBlock = [self.blockFactory blockForKey:@""];
        [subArray addObject:newBlock];
    }
    [newArray insertObject:subArray atIndex:0];
    
    return newArray;
}

// Check to see if the position has a collision
- (BOOL) collision: (NSInteger) row column:(NSInteger)column
{
    if([self offScreen:row column:column] || [self inLocation:row column:column])
        return true;
    else
        return false;
}

// Check to see if the position is occupied
- (BOOL) inLocation: (NSInteger) row column:(NSInteger)column
{
    Block *locationBoardCheck = [[self.gameArray objectAtIndex:row] objectAtIndex:column];
    if([locationBoardCheck blockExist])
        return true;
    else
        return false;
}

// Check to see if the position is off the screen
- (BOOL) offScreen:(NSInteger)row column:(NSInteger)column
{
    if(row >= BOARD_ROWS)
        return true;
    else if(column >= BOARD_COLS)
        return true;
    else if(column < 0)
        return true;
    else
        return false;
}

@end
