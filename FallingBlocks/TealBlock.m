//
//  TealBlock.m
//  myFallingBlocks
//
//  Created by Nate Rowan on 2/21/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "TealBlock.h"

@implementation TealBlock
- (UIView *) returnBlock
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TealBlock.png"]];
    return background;
}
@end
