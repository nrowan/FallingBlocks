//
//  GameViewController.h
//  FallingBlocks
//
//  Created by Nate Rowan on 2/9/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "FallingBlocks.h"
#import "RenderView.h"
#import "PauseView.h"

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
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UIView *gameScreenView;
@property (weak, nonatomic) IBOutlet UIView *PauseMenuView;
@property (weak, nonatomic) IBOutlet UILabel *level;

- (IBAction)pauseButtonPressed:(id)sender;
- (IBAction)rotateButtonPressed:(id)sender;
- (IBAction)dropButtonPressed:(id)sender;
- (IBAction)moveButtonPressed:(id)sender;
@end
