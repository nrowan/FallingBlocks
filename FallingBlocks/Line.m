//
//  Line.m
//  myFallingBlocks
//
//  Created by Nate Rowan on 2/14/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "Line.h"
#import "Block.h"
#import "BlockFactory.h"

@implementation Line

- (NSMutableArray *) getOrientation: (NSInteger) orientation
{
    NSMutableArray *tempPiece = [[NSMutableArray alloc] init];
    if([self isNorth: orientation] || [self isSouth: orientation])
    {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        [column addObject:[self getBlockType: TRUE]];
        [column addObject:[self getBlockType: TRUE]];
        [column addObject:[self getBlockType: TRUE]];
        [column addObject:[self getBlockType: TRUE]];
        [tempPiece addObject:column];
    }
    else if([self isEast: orientation] || [self isWest: orientation])
    {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        [column addObject:[self getBlockType: TRUE]];
        [tempPiece addObject:column];
        
        NSMutableArray *column2 = [[NSMutableArray alloc] init];
        [column2 addObject:[self getBlockType: TRUE]];
        [tempPiece addObject:column2];
        
        NSMutableArray *column3 = [[NSMutableArray alloc] init];
        [column3 addObject:[self getBlockType: TRUE]];
        [tempPiece addObject:column3];
        
        NSMutableArray *column4 = [[NSMutableArray alloc] init];
        [column4 addObject:[self getBlockType: TRUE]];
        [tempPiece addObject:column4];
    }
    return tempPiece;
}

- (Block *) getBlockType: (bool) filled
{
    if(filled)
    {
        return [self.blockFactory blockForKey:@"pink"];
    }
    else
    {
        Block *tempBlock = [[Block alloc] init];
        return tempBlock;
    }
}

@end
