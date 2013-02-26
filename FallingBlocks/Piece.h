//
//  Piece.h
//  myFallingBlocks
//
//  Created by Nate Rowan on 2/13/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BlockFactory;

@interface Piece : NSObject
@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger column;
@property (nonatomic) NSInteger orientation;
@property (nonatomic) NSTimeInterval pieceDropEveryDefault;
@property (nonatomic) NSTimeInterval pieceDropEvery;
@property (nonatomic) NSTimeInterval pieceTimeSinceLastMoved;
@property (strong, nonatomic) NSMutableArray *pieceOrientations;
@property (strong) BlockFactory *blockFactory;

- (id) init:(NSTimeInterval) speed blockFactory: (BlockFactory *) blockFactory;
- (void) setPosition:(NSInteger) row column: (NSInteger) column;
- (void) rotate;
- (void) unrotate;
- (void) drop;
- (NSMutableArray *) getOrientation: (NSInteger) orientation;
- (BOOL) isNorth: (NSInteger) passedOrientation;
- (BOOL) isSouth: (NSInteger) passedOrientation;
- (BOOL) isWest: (NSInteger) passedOrientation;
- (BOOL) isEast: (NSInteger) passedOrientation;
- (NSMutableArray *) getPieceArray;

@end
