//
//  Block.m
//  FallingBlocks
//
//  Created by Nate Rowan on 2/21/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "Block.h"

@implementation Block

- (id) init
{
    self.blockView = [[UIView alloc] init];
    self.blockView = [self returnBlock];
    
    return self;
}

- (UIView *) returnBlock
{
    return NULL;
}

- (bool) blockExist
{
    if(self.blockView)
        return TRUE;
    else
        return FALSE;
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
