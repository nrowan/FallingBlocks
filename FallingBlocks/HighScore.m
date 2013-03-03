//
//  HighScore.m
//  FallingBlocks
//
//  Created by Nate Rowan on 2/28/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "HighScore.h"

@implementation HighScore

- (id) init
{
    if (self = [super init])
    {
        NSMutableArray *highScores = nil;
        //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key"];
        highScores = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Key"]];
        
        
        // If the high scores don't exist create and store them
        if ([highScores count] == 0)
        {
            for (int i = 0; i < 10; i++) {
                [highScores addObject:[NSNumber numberWithInt:0]];
            }
            [[NSUserDefaults standardUserDefaults] setObject:highScores forKey:@"Key"];
        }
    }
    
    return self;
}

// Get the high score from NSUserDefaults and return it in an array
- (NSMutableArray *) getHighScoreArray
{
    NSMutableArray *highScores = nil;
    
    // Get high scores from user defaults and sort
    highScores = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Key"]];
    [highScores sortedArrayUsingSelector:@selector(compare:)];
    
    return highScores;
}

// Check to see if the passed score is a high score
- (BOOL) checkHighScore: (NSInteger) score
{
    NSMutableArray *highScores = [self getHighScoreArray];
    
    NSInteger highScoreCount = [highScores count];
    BOOL newHighScore = FALSE;
    for (int i = 0; i < highScoreCount; i++)
    {
        if(score > [[highScores objectAtIndex:i] integerValue])
        {
            // If a new high score insert it and store it in file
            [self insertHighScore: highScores score: score];
            [[NSUserDefaults standardUserDefaults] setObject:highScores forKey:@"Key"];
            newHighScore = TRUE;
            break;
        }
    }
    
    /*for (int i = 0; i <[highScores count]; i++) {
        NSLog(@"score: %d", [[highScores objectAtIndex:i] integerValue]);
    }*/
    
    return newHighScore;
}

// Add the object and then remove the last item
- (void) insertHighScore: (NSMutableArray *) highScores score: (NSInteger) score
{
    // Add the new score
    [highScores addObject:[NSNumber numberWithInt: score]];
    [highScores sortedArrayUsingSelector:@selector(compare:)];
    [highScores removeObjectAtIndex:0];
}


@end
