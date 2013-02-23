//
//  BlockFactory.h
//  FallingBlocks
//
//  Created by Nate Rowan on 2/22/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Block.h"

@interface BlockFactory : NSObject
+ (BlockFactory *)factory;
- (Block *)blockForKey:(NSString *)blockKey;
- (BOOL) doesBlockExist: (Block *) passedBlock;
- (UIView *) returnBlock: (Block *) passedBlock;
@end
