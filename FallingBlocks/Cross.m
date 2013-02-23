//
//  Cross.m
//  FallingBlocks
//
//  Created by Nate Rowan on 2/14/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "Cross.h"
#import "Block.h"
#import "BlockFactory.h"

@implementation Cross

- (NSMutableArray *) getOrientation: (NSInteger) orientation
{
    NSMutableArray *tempPiece = [[NSMutableArray alloc] init];
    if([self isNorth: orientation] || [self isSouth: orientation])
    {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        NSMutableArray *column2 = [[NSMutableArray alloc] init];
        NSMutableArray *column3 = [[NSMutableArray alloc] init];
        if([self isNorth: orientation])
        {
            [column addObject:[self getBlockType: TRUE]];
            [column addObject:[self getBlockType: FALSE]];
            
            [column2 addObject:[self getBlockType: TRUE]];
            [column2 addObject:[self getBlockType: TRUE]];
            
            [column3 addObject:[self getBlockType: TRUE]];
            [column3 addObject:[self getBlockType: FALSE]];
        }
        else
        {
            [column addObject:[self getBlockType: FALSE]];
            [column addObject:[self getBlockType: TRUE]];
            
            [column2 addObject:[self getBlockType: TRUE]];
            [column2 addObject:[self getBlockType: TRUE]];
            
            [column3 addObject:[self getBlockType: FALSE]];
            [column3 addObject:[self getBlockType: TRUE]];
        }
        
        [tempPiece addObject:column];
        [tempPiece addObject:column2];
        [tempPiece addObject:column3];
    }
    else if ([self isEast: orientation] || [self isWest: orientation])
    {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        NSMutableArray *column2 = [[NSMutableArray alloc] init];
        
        if([self isEast: orientation])
        {
            [column addObject:[self getBlockType: TRUE]];
            [column addObject:[self getBlockType: TRUE]];
            [column addObject:[self getBlockType: TRUE]];
            
            [column2 addObject:[self getBlockType: FALSE]];
            [column2 addObject:[self getBlockType: TRUE]];
            [column2 addObject:[self getBlockType: FALSE]];
        }
        else
        {
            [column addObject:[self getBlockType: FALSE]];
            [column addObject:[self getBlockType: TRUE]];
            [column addObject:[self getBlockType: FALSE]];
            
            [column2 addObject:[self getBlockType: TRUE]];
            [column2 addObject:[self getBlockType: TRUE]];
            [column2 addObject:[self getBlockType: TRUE]];
        }
        [tempPiece addObject:column];
        [tempPiece addObject:column2];
    }
    return tempPiece;
}

- (Block *) getBlockType: (bool) filled
{
    if(filled)
    {
        return [self.blockFactory blockForKey:@"blue"];
    }
    else
    {
        Block *tempBlock = [[Block alloc] init];
        return tempBlock;
    }
}

@end
