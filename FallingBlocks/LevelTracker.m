//
//  LevelTracker.m
//  FallingBlocks
//
//  Created by Nate Rowan on 2/25/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "LevelTracker.h"

@implementation LevelTracker
@synthesize level = _level;
@synthesize levelDetails = _levelDetails;

const double TOTAL_LEVELS = 50;
const NSInteger SCORE_MULTIPLIER = 1;

- (id) init
{
    if (self = [super init])
    {
        self.level = 1;
        
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
    }
    
    return self;
}

- (void) newLevel: (NSInteger) score
{
    // Increase level if score is greater than current level's max points required
    if(score >= [[[self.levelDetails objectAtIndex:self.level-1] objectAtIndex:1] integerValue] && self.level < TOTAL_LEVELS)
        self.level++;
}

- (double) getLevelSpeed
{
    return [[[self.levelDetails objectAtIndex:self.level-1] objectAtIndex:0 ] doubleValue];
}

@end
