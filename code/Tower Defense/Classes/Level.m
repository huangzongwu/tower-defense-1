//
//  Level.m
//  Tower Defense
//
//  Created by Tim Lukens on 2/21/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import "Level.h"
#import "Enemy.h"


@implementation Level

@synthesize tileMap = tileMap_;
@synthesize meta = meta_;
@synthesize enemies = enemies_;

-(id)initWithLevel:(NSUInteger)level {
	if( (self=[super init]) ) {
		enemies_ = [[NSMutableArray alloc] init];
		
		tileMap_ = [CCTMXTiledMap tiledMapWithTMXFile:[NSString stringWithFormat:@"level%d.tmx", level]];
		background_ = [tileMap_ layerNamed:@"Background"];
		
		CCTMXObjectGroup* enemies = [tileMap_ objectGroupNamed:@"Enemies"];
		NSMutableDictionary* spawnPoint = [enemies objectNamed:@"Spawn"];
		spawnPoint_.x = [[spawnPoint valueForKey:@"x"] intValue];
		spawnPoint_.y = [[spawnPoint valueForKey:@"y"] intValue];
		
		meta_ = [tileMap_ layerNamed:@"Meta"];
		meta_.visible = NO;
		
		[self addChild:tileMap_ z:-1];
		[self schedule:@selector(update:)];
		[self schedule:@selector(gameLogic:) interval:1.0f];
	}
	return self;
}

-(void)gameLogic:(ccTime)dt {
	Enemy* enemy = [[Enemy node] init];
	enemy.position = ccp(spawnPoint_.x, spawnPoint_.y);
	[enemies_ addObject:enemy];
	[self addChild:enemy];
}

-(void)update:(ccTime)dt {
	for(Enemy* enemy in [enemies_ allObjects]) {
		[enemy move];
	}
}

-(CGPoint)tileCoordForPosition:(CGPoint)position {
    int x = position.x / tileMap_.tileSize.width;
    int y = ((tileMap_.mapSize.height * tileMap_.tileSize.height) - position.y) / tileMap_.tileSize.height;
    return ccp(x, y);
}

@end
