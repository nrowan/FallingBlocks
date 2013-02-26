//
//  LevelTracker.h
//  FallingBlocks
//
//  Created by Nate Rowan on 2/25/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelTracker : NSObject

extern const double TOTAL_LEVELS;
extern const NSInteger SCORE_MULTIPLIER;

@property (nonatomic) NSInteger level;
@property (strong) NSMutableArray *levelDetails;

- (id) init;
- (void) newLevel: (NSInteger) score;
- (double) getLevelSpeed;

@end
