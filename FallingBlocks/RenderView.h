//
//  RenderView.h
//  myFallingBlocks
//
//  Created by Nate Rowan on 2/12/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RenderView : UIView
@property (nonatomic) CGFloat blockSize;
@property (nonatomic) NSInteger gameRenderRows;
@property (nonatomic) NSInteger gameRenderColumns;
@property (strong, nonatomic) NSMutableArray *gameViewArray;
@property (nonatomic) CGFloat gameHeightPoints;
@property (nonatomic) CGFloat gameWidthPoints;

- (id) initWithFrame: (CGRect)frame screenSize: (CGRect) screenSize;
- (void) renderGame: (NSMutableArray *) game;
@end
