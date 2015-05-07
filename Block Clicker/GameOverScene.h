//
//  GameOverScene.h
//  Block Clicker
//
//  Created by Travis McMahon on 5/6/15.
//  Copyright (c) 2015 Travis McMahon. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LeaderboardScene.h"
#import "GameDataHelper.h"

@interface GameOverScene : SKScene <UITextFieldDelegate>
@property UITextField *textField;
@property SKLabelNode *ok;
@end
