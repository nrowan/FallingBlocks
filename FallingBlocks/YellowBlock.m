//
//  YellowBlock.m
//  myFallingBlocks
//
//  Created by Nate Rowan on 2/21/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "YellowBlock.h"

@implementation YellowBlock
- (UIView *) returnBlock
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"YellowBlock.png"]];
    return background;
}
@end
