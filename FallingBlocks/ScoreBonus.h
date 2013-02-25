//
//  ScoreBonus.h
//  FallingBlocks
//
//  Created by Nate Rowan on 2/24/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScoreBonus <NSObject>

@property NSInteger bonusTotal;

- (id) init;
- (BOOL) isBonusDone;
- (NSInteger) getBonus;

@optional
- (void) rowsCleared: (NSInteger) lines;

@end
