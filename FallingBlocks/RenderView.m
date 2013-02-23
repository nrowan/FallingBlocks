//
//  RenderView.m
//  myFallingBlocks
//
//  Created by Nate Rowan on 2/12/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "RenderView.h"
#import <QuartzCore/QuartzCore.h>
#import "Block.h"

@implementation RenderView

@synthesize blockSize = _blockSize;
@synthesize gameViewArray = _gameViewArray;
@synthesize gameRenderRows = _gameRenderRows;
@synthesize gameRenderColumns = _gameRenderColumns;
@synthesize gameHeightPoints = _gameHeightPoints;
@synthesize gameWidthPoints = _gameWidthPoints;

- (id)initWithFrame:(CGRect)frame screenSize: (CGRect) screenSize
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setGameDimensions];
        
        self.backgroundColor = [UIColor blackColor];
    }
    
    return self;
}

// Create the area in points for the game view
- (void) setGameDimensions
{
    self.gameHeightPoints = 400;
    self.gameWidthPoints = 200;
}

// Render the game according to the passed game array
- (void) renderGame: (NSMutableArray *) game
{
    // Setup the view array that will store all the views for the game
    if(!self.gameViewArray)
    {
        NSInteger gameRows = [game count];
        NSInteger gameColumns = [[game objectAtIndex:0] count];
        [self createGameViewArray: gameRows gameRenderColumns:gameColumns];
    }
    
    // Clear board first otherwise it leaves a trail
    [self clearBoard];
    
    // Loop through the game array and update the view array according to it
    UIView *tempView;
    Block *tempBlock;
    for (int i = 0; i < self.gameRenderRows; i++) {
        for (int j=0; j < self.gameRenderColumns; j++) {
            tempView = [[self.gameViewArray objectAtIndex:i] objectAtIndex:j];
            tempBlock = [[game objectAtIndex:i] objectAtIndex:j];
            if([tempBlock blockExist])
            {
                [tempView addSubview:tempBlock.blockView];
            }
        }
    }
}

- (void) clearBoard
{
    UIView *tempView;
    for (int i = 0; i < self.gameRenderRows; i++) {
        for (int j=0; j < self.gameRenderColumns; j++) {
            tempView = [[self.gameViewArray objectAtIndex:i] objectAtIndex:j];
            for (int i = 0; i < [[tempView subviews] count]; i++ ) {
                [[[tempView subviews] objectAtIndex:i] removeFromSuperview];
            }
        }
    }
}

// Create the game view array based on the number of rows and columns
- (void) createGameViewArray:(NSInteger) gameRenderRows gameRenderColumns: (NSInteger) gameRenderColumns
{
    // Set the number of rows and columns for the board on the screen
    self.gameRenderRows = gameRenderRows;
    self.gameRenderColumns = gameRenderColumns;
    
    // Calculate the size of an individual block based on the number of rows and the screen points being used for the game
    self.blockSize = self.gameHeightPoints / self.gameRenderRows;
    
    self.gameViewArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *tempColumn;
    
    for (int i = 0; i < self.gameRenderRows; i++) {
        tempColumn = [[NSMutableArray alloc] init];
        for (int j=0; j < self.gameRenderColumns; j++) {
            CGRect myRect = CGRectMake((j*self.blockSize), (i*self.blockSize), self.blockSize, self.blockSize);
            UIView *rectView = [[UIView alloc] initWithFrame:myRect];
            rectView.backgroundColor = [UIColor clearColor];
            rectView.layer.borderColor = [[UIColor whiteColor] CGColor];
            rectView.layer.borderWidth = 0.0;
            
            [tempColumn addObject:rectView];
        }
        [self.gameViewArray addObject:tempColumn];
    }
    
    for (int i = 0; i < self.gameRenderRows; i++) {
        for (int j=0; j < self.gameRenderColumns; j++) {
            [self addSubview:[[self.gameViewArray objectAtIndex:i] objectAtIndex:j]];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
