//
//  GameViewController.h
//  FallingBlocks
//
//  Created by Nate Rowan on 2/9/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FallingBlocks;
@class RenderView;
@class PauseView;
@class ScoreTracker;
@class LevelTracker;
@class BlockFactory;

@interface GameViewController : UIViewController
extern const int SCREEN_HEIGHT_POINTS;
extern const int SCREEN_WIDTH_POINTS;

@property (nonatomic) CGRect *screenSize;
@property (strong)FallingBlocks *myFallingBlocks;
@property (strong)RenderView *gameView;
@property (strong) CADisplayLink *myTimer;
@property (nonatomic) NSDate *myPreviousTick;
@property (nonatomic) BOOL pause;
@property (strong) PauseView *pauseView;
@property (strong) BlockFactory *blockFactory;
@property (strong) ScoreTracker *scoreTracker;
@property (strong) LevelTracker *levelTracker;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UIView *gameScreenView;
@property (weak, nonatomic) IBOutlet UIView *PauseMenuView;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

- (IBAction)pauseButtonPressed:(id)sender;
- (IBAction)rotateButtonPressed:(id)sender;
- (IBAction)dropButtonPressed:(id)sender;
- (IBAction)moveButtonPressed:(id)sender;
@end
