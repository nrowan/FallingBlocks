//
//  ScoreTracker.m
//  FallingBlocks
//
//  Created by Nate Rowan on 2/22/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "ScoreTracker.h"
#import "LineBonus.h"
#import "ConsecutiveBonus.h"
#import "ScoreBonus.h"

@implementation ScoreTracker
@synthesize score = _score;
@synthesize bonuses = _bonuses;

- (id) init
{
    if (self = [super init])
    {
        self.score = 0;
        self.bonuses = [[NSMutableArray alloc] init];
        
        id<ScoreBonus> tempLineBonus = [[LineBonus alloc] init];
        id<ScoreBonus> tempConsecBonus = [[ConsecutiveBonus alloc] init];
        
        [self.bonuses addObject:tempLineBonus];
        [self.bonuses addObject:tempConsecBonus];
    }
    
    return self;
}

- (void) addAllBonuses
{
    for (id<ScoreBonus> bonus in self.bonuses) {
        if (bonus.isBonusDone) {
            self.score += [bonus getBonus];
        }
    }
}

- (void) rowsCleared:(NSMutableArray *)rowsCleared level:(NSInteger)level
{
    self.score += [rowsCleared count];
    for (id<ScoreBonus> bonus in self.bonuses) {
        [bonus rowsCleared:[rowsCleared count]];
    }
}
@end
