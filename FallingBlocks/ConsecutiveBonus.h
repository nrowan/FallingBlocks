//
//  ConsecutiveBonus.h
//  FallingBlocks
//
//  Created by Nate Rowan on 2/24/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoreBonus.h"

@interface ConsecutiveBonus : NSObject <ScoreBonus>

@property NSInteger consecutiveMaxLines;
@property NSInteger bonusTotal;
@property BOOL bonusReady;

- (id) init;
- (NSInteger) getBonus;
- (BOOL) isBonusDone;
- (void) rowsCleared: (NSInteger) lines;

@end
