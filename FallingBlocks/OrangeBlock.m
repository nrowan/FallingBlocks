//
//  OrangeBlock.m
//  myFallingBlocks
//
//  Created by Nate Rowan on 2/21/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "OrangeBlock.h"

@implementation OrangeBlock
- (UIView *) returnBlock
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OrangeBlock.png"]];
    return background;
}
@end
