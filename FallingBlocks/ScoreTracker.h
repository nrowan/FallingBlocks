//
//  ScoreTracker.h
//  FallingBlocks
//
//  Created by Nate Rowan on 2/22/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreTracker : NSObject

@property NSInteger score;
@property (strong) NSMutableArray *bonuses;

- (id) init;
- (void) addAllBonuses;
- (void) rowsCleared: (NSMutableArray *) rowsCleared level:(NSInteger) level;

@end
