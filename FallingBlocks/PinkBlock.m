//
//  PinkBlock.m
//  myFallingBlocks
//
//  Created by Nate Rowan on 2/21/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "PinkBlock.h"

@implementation PinkBlock

- (UIView *) returnBlock
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PinkBlock.png"]];
    return background;
}
@end
