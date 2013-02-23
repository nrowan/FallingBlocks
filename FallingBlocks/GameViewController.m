//
//  GameViewController.m
//  FallingBlocks
//
//  Created by Nate Rowan on 2/9/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "GameViewController.h"
#import "FallingBlocks.h"
#import "RenderView.h"
#import "PauseView.h"
#import "BlockFactory.h"
#import <QuartzCore/QuartzCore.h>

@implementation GameViewController

@synthesize myFallingBlocks = _myFallingBlocks;
@synthesize myTimer = _myTimer;
@synthesize screenSize = _screenSize;
@synthesize pause = _pause;
@synthesize myPreviousTick = _myPreviousTick;

const int SCREEN_HEIGHT_POINTS = 400;
const int SCREEN_WIDTH_POINTS = 200;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) doFrame:(id)sender
{
    if(!self.pause)
    {
        NSTimeInterval timespan;
        if (self.myPreviousTick)
            timespan = fabs([self.myPreviousTick timeIntervalSinceNow]);
        else
            timespan = 0;
        self.myPreviousTick = [NSDate date];
        
        // If the game is over cancel the timer
        if (![self.myFallingBlocks advanceGame:timespan]) {
            [self.myTimer invalidate];
            self.score.text = [NSString stringWithFormat:@"Lose"];
        }
        else
        {
            self.score.text = [NSString stringWithFormat:@"%d", [self.myFallingBlocks score]];
            self.level.text = [NSString stringWithFormat:@"%d", [self.myFallingBlocks level]];
            [self.gameView renderGame:[self.myFallingBlocks gameDisplayArray]];
        }
    }
}

- (void) startNewGame
{
    self.myFallingBlocks = NULL;
    self.myPreviousTick = NULL;
    self.pause = FALSE;
    self.myTimer = NULL;
    self.score.text = @"";
    self.blockFactory = NULL;

    self.blockFactory = [BlockFactory factory];
    self.myFallingBlocks = [[FallingBlocks alloc] init: self.blockFactory];
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    if(!self.gameView)
    {
        self.gameView = [[RenderView alloc] initWithFrame:CGRectMake(20, 0, 200, 400) screenSize:screen];
        self.gameView.layer.borderWidth = 1.0;
        [self.gameScreenView addSubview:self.gameView];
    }
    if(!self.pauseView)
    {
        self.pauseView = [[PauseView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
        [self.view addSubview:self.pauseView];
    }
    self.pauseView.hidden = TRUE;

    // Setup a timer to call game loop 60fps
    self.myTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(doFrame:)];
    self.myTimer.frameInterval = 1;
    [self.myTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self startNewGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) mainMenuButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"returnMainMenuSegue" sender:sender];
}

- (void) restartButtonPressed:(id)sender {
    [self startNewGame];
}

- (IBAction)pauseButtonPressed:(id)sender {
    self.pause = TRUE;
    self.pauseView.hidden = FALSE;
}

- (void)resumeButtonPressed:(id)sender {
    self.myPreviousTick = [NSDate date];
    self.pause = FALSE;
    self.pauseView.hidden = TRUE;
}

- (IBAction)rotateButtonPressed:(id)sender {
    [self.myFallingBlocks rotate];
}

- (IBAction)dropButtonPressed:(id)sender {
    [self.myFallingBlocks drop];
}

- (IBAction)moveButtonPressed:(id)sender {
    if((UIButton *) sender == self.leftButton) {
        [self.myFallingBlocks moveHorizontal:@"left"];
    }
    else if((UIButton *) sender == self.rightButton) {
        [self.myFallingBlocks moveHorizontal:@"right"];
    }
}
@end
