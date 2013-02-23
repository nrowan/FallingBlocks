//
//  Square.m
//  myFallingBlocks
//
//  Created by Nate Rowan on 2/14/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "Square.h"
#import "Block.h"
#import "BlockFactory.h"

@implementation Square

- (NSMutableArray *) getOrientation: (NSInteger) orientation
{
    NSMutableArray *tempPiece = [[NSMutableArray alloc] init];
    if([self isNorth: orientation] || [self isEast: orientation] || [self isSouth: orientation] || [self isWest: orientation])
    {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        [column addObject:[self getBlockType: TRUE]];
        [column addObject:[self getBlockType: TRUE]];
        [tempPiece addObject:column];
        
        NSMutableArray *column2 = [[NSMutableArray alloc] init];
        [column2 addObject:[self getBlockType: TRUE]];
        [column2 addObject:[self getBlockType: TRUE]];
        [tempPiece addObject:column2];
    }
    return tempPiece;
}

- (Block *) getBlockType: (bool) filled
{
    if(filled)
    {
        return [self.blockFactory blockForKey:@"red"];
    }
    else
    {
        Block *tempBlock = [[Block alloc] init];
        return tempBlock;
    }
}

@end
