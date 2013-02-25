//
//  LineBonus.m
//  FallingBlocks
//
//  Created by Nate Rowan on 2/24/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "LineBonus.h"

@implementation LineBonus

- (id) init
{
    self.bonusTotal = 0;
    self.bonusReady = FALSE;
    
    return self;
}

- (void) rowsCleared:(NSInteger)lines
{
    self.bonusTotal = lines*lines;
    self.bonusReady = TRUE;
}

- (BOOL) isBonusDone
{
    return self.bonusReady;
}

- (NSInteger) getBonus
{
    // If the bonus isn't ready return 0. Safety in case calling function doesn't check
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
@end
