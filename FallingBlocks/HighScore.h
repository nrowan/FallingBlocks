//
//  HighScore.h
//  FallingBlocks
//
//  Created by Nate Rowan on 2/28/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScore : NSObject

- (id) init;
- (BOOL) checkHighScore: (NSInteger) score;
- (NSMutableArray *) getHighScoreArray;

@end
