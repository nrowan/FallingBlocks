//
//  ConsecutiveBonus.m
//  FallingBlocks
//
//  Created by Nate Rowan on 2/24/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "ConsecutiveBonus.h"

@implementation ConsecutiveBonus
@synthesize consecutiveMaxLines = _consecutiveMaxLines;
@synthesize bonusReady = _bonusReady;
@synthesize bonusTotal = _bonusTotal;

- (id) init
{
    self.bonusTotal = 0;
    self.consecutiveMaxLines = 0;
    self.bonusReady = FALSE;
    
    return self;
}

- (void) rowsCleared:(NSInteger)lines
{
    if(lines == 4)
    {
        self.consecutiveMaxLines++;
    }
    else if(lines == 1 || lines == 2 || lines == 3)
    {
        if (self.consecutiveMaxLines != 0) {
            self.bonusTotal = self.consecutiveMaxLines * 10;
            self.consecutiveMaxLines = 0;
            self.bonusReady = TRUE;
        }
    }
}

- (NSInteger) getBonus
{
    if(self.bonusReady)
    {
        NSInteger tempBonusTotal = self.bonusTotal;
        self.bonusTotal = 0;
        self.bonusReady = FALSE;
        return tempBonusTotal;
    }
    else
        return 0;
}
- (BOOL) isBonusDone;
{
    return self.bonusReady;
}

@end
