//
//  Level.h
//  Tower Defense
//
//  Created by Tim Lukens on 2/21/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Level : CCNode {
	CCTMXTiledMap* tileMap_;
	CCTMXLayer* background_;
	CCTMXLayer* meta_;
	
	CGPoint spawnPoint_;
	
	NSMutableArray* enemies_;
}

@property (nonatomic, retain) CCTMXTiledMap* tileMap;
@property (nonatomic, retain) CCTMXLayer* meta;
@property (nonatomic, retain) NSMutableArray* enemies;

-(id)initWithLevel:(NSUInteger)level;
-(CGPoint)tileCoordForPosition:(CGPoint)position;

@end
