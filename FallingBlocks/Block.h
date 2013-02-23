//
//  Block.h
//  FallingBlocks
//
//  Created by Nate Rowan on 2/21/13.
//  Copyright (c) 2013 Nate Rowan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Block : NSObject

@property (strong) UIView *blockView;

- (UIView *) returnBlock;
- (bool) blockExist;
@end
