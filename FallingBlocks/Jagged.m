//
//  Jagged.m
//  myFallingBlocks
//
//  Created by Nate Rowan on 2/14/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "Jagged.h"
#import "Block.h"
#import "BlockFactory.h"

@implementation Jagged

- (NSMutableArray *) getOrientation: (NSInteger) orientation
{
    NSMutableArray *tempPiece = [[NSMutableArray alloc] init];
    if([self isNorth: orientation] || [self isSouth: orientation])
    {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        [column addObject:[self getBlockType: TRUE]];
        [column addObject:[self getBlockType: TRUE]];
        [column addObject:[self getBlockType: FALSE]];
        [tempPiece addObject:column];
        
        NSMutableArray *column2 = [[NSMutableArray alloc] init];
        [column2 addObject:[self getBlockType: FALSE]];
        [column2 addObject:[self getBlockType: TRUE]];
        [column2 addObject:[self getBlockType: TRUE]];
        [tempPiece addObject:column2];
    }
    else if([self isEast: orientation] || [self isWest: orientation])
    {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        [column addObject:[self getBlockType: FALSE]];
        [column addObject:[self getBlockType: TRUE]];
        [tempPiece addObject:column];
        
        NSMutableArray *column2 = [[NSMutableArray alloc] init];
        [column2 addObject:[self getBlockType: TRUE]];
        [column2 addObject:[self getBlockType: TRUE]];
        [tempPiece addObject:column2];
        
        NSMutableArray *column3 = [[NSMutableArray alloc] init];
        [column3 addObject:[self getBlockType: TRUE]];
        [column3 addObject:[self getBlockType: FALSE]];
        [tempPiece addObject:column3];
    }
        
    return tempPiece;
}

- (Block *) getBlockType: (bool) filled
{
    if(filled)
    {
        return [self.blockFactory blockForKey:@"green"];
    }
    else
    {
        Block *tempBlock = [[Block alloc] init];
        return tempBlock;
    }
}

@end
