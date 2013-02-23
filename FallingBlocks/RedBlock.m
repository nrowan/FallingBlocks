//
//  Red.m
//  myFallingBlocks
//
//  Created by Nate Rowan on 2/21/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "RedBlock.h"

@implementation RedBlock

- (UIView *) returnBlock
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RedBlock.png"]];
    return background;
}
@end
