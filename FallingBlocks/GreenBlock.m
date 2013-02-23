//
//  GreenBlock.m
//  FallingBlocks
//
//  Created by Nate Rowan on 2/21/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "GreenBlock.h"

@implementation GreenBlock

- (UIView *) returnBlock
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GreenBlock.png"]];
    return background;
}
@end
