//
//  BlockFactory.m
//  FallingBlocks
//
//  Created by Nate Rowan on 2/22/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import "BlockFactory.h"
#import "Block.h"
#import "RedBlock.h"
#import "BlueBlock.h"
#import "GreenBlock.h"
#import "PinkBlock.h"
#import "OrangeBlock.h"
#import "YellowBlock.h"
#import "TealBlock.h"

@implementation BlockFactory
+ (BlockFactory *)factory {
    return [[[self class] alloc] init];
}
- (Block *)blockForKey:(NSString *)blockKey {
    Block *block = nil;
    if ([blockKey isEqualToString:@"blue"]) {
        block = [[BlueBlock alloc] init];
    } else if ([blockKey isEqualToString:@"green"]) {
        block = [[GreenBlock alloc] init];
    }else if ([blockKey isEqualToString:@"orange"]) {
        block = [[OrangeBlock alloc] init];
    }else if ([blockKey isEqualToString:@"pink"]) {
        block = [[PinkBlock alloc] init];
    }else if ([blockKey isEqualToString:@"red"]) {
        block = [[RedBlock alloc] init];
    }else if ([blockKey isEqualToString:@"teal"]) {
        block = [[TealBlock alloc] init];
    }else if ([blockKey isEqualToString:@"yellow"]) {
        block = [[YellowBlock alloc] init];
    } else {
        block = [[Block alloc] init];
    }
    return block;
}

- (BOOL) doesBlockExist: (Block *) passedBlock
{
    return [passedBlock blockExist];
}

- (UIView *) returnBlock: (Block *) passedBlock
{
    return [passedBlock returnBlock];
}

@end
