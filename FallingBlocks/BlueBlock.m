//
//  BlueBlock.m
//  FallingBlocks
//
//  Created by Nate Rowan on 2/21/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "BlueBlock.h"

@implementation BlueBlock

- (UIView *) returnBlock
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlueBlock.png"]];
    return background;
}
@end
