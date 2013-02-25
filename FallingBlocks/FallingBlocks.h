//
//  FallingBlocks.h
//  FallingBlocks
//
//  Created by Nate Rowan on 2/10/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Piece.h"
#import "ScoreTracker.h"

@interface FallingBlocks : NSObject

extern const double TOTAL_LEVELS;
extern const NSInteger SCORE_MULTIPLIER;

extern const NSInteger BOARD_ROWS;
extern const NSInteger BOARD_ROWS_VISIBLE;
extern const NSInteger BOARD_COLS;

extern const NSInteger PIECE_START_ROW;
extern const NSInteger PIECE_START_COLUMN;

@property (nonatomic) NSInteger level;
@property (strong) NSMutableArray *gameArray;
@property (strong, nonatomic) Piece *fallingPiece;
@property (strong) NSMutableArray *levelDetails;
@property (strong) BlockFactory *blockFactory;
@property (strong) ScoreTracker *scoreTracker;

- (id) init: (BlockFactory *) blockFactory scoreTracker: (ScoreTracker *) scoreTracker;
- (NSInteger) fallingBlocksRenderRows;
- (NSInteger) fallingBlocksRenderColumns;
- (BOOL) advanceGame:(NSTimeInterval) deltatime;
- (void) rotate;
- (void) drop;
- (void) moveHorizontal:(NSString *) direction;
- (NSMutableArray *) gameDisplayArray;

@end
