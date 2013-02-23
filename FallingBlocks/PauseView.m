//
//  PauseView.m
//  myFallingBlocks
//
//  Created by Nate Rowan on 2/19/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "PauseView.h"

@implementation PauseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.9];
        self.userInteractionEnabled = TRUE;
        
        NSInteger buttonWidth = 100;
        NSInteger buttonHeight = 50;
        NSInteger buttonSpacing = 25;
        NSInteger buttonViewHeight = buttonHeight*3 + buttonSpacing*2;
        
        NSString *pauseLabel = @"Paused";
        CGFloat constrainedSize = 265.0f;
        UIFont * myFont = [UIFont fontWithName:@"Chalkduster" size:50];
        
        CGSize textSize = [pauseLabel sizeWithFont: myFont
                             constrainedToSize:CGSizeMake(constrainedSize, CGFLOAT_MAX)
                                 lineBreakMode:NSLineBreakByCharWrapping];
        CGRect labelFrame = CGRectMake (0, 0, textSize.width, textSize.height);
        UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
        [label setFont:myFont];
        [label setText:pauseLabel];
        [label setBackgroundColor:[UIColor clearColor]];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        CGPoint center = label.center;
        center.x = self.center.x;
        center.y = 75;
        label.center = center;
        
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonViewHeight)];
        
        UIButton *resumeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [resumeButton setTitle:@"Resume" forState:UIControlStateNormal];
        [resumeButton addTarget:nil action:@selector(resumeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        resumeButton.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
        
        UIButton *restartButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [restartButton setTitle:@"Restart" forState:UIControlStateNormal];
        [restartButton addTarget:nil action:@selector(restartButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        restartButton.frame = CGRectMake(0, buttonHeight + buttonSpacing, buttonWidth, buttonHeight);
        
        UIButton *mainMenuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [mainMenuButton setTitle:@"Main Menu" forState:UIControlStateNormal];
        [mainMenuButton addTarget:nil action:@selector(mainMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        mainMenuButton.frame = CGRectMake(0, buttonHeight*2 + (buttonSpacing*2), buttonWidth, buttonHeight);
        
        [tempView addSubview:restartButton];
        [tempView addSubview:resumeButton];
        [tempView addSubview:mainMenuButton];
        [self addSubview:tempView];
        tempView.center = self.center;
    }
    return self;
}

@end
