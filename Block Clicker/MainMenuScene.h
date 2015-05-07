//
//  MainMenuScene.h
//  Block Clicker
//
//  Created by Travis McMahon on 3/26/15.
//  Copyright (c) 2015 Travis McMahon. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"
#import "LeaderboardScene.h"
#import "GameOverScene.h"

@interface MainMenuScene : SKScene
@property SKLabelNode *play;
@property SKLabelNode *leaderboards;
@property SKLabelNode *reset;
@end
