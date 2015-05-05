//
//  MainMenuScene.m
//  Block Clicker
//
//  Created by Travis McMahon on 3/26/15.
//  Copyright (c) 2015 Travis McMahon. All rights reserved.
//

#import "MainMenuScene.h"

@interface MainMenuScene()
@end

@implementation MainMenuScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    // Background
    self.backgroundColor = [UIColor colorWithRed:0.816 green:0.957 blue:0.969 alpha:1.0];
    
    // play button
    self.play = [SKLabelNode labelNodeWithFontNamed:@"Avenir-BlackOblique"];
    self.play.text = @"Play";
    self.play.fontSize = 50;
    self.play.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.play.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 50);
    
    // leaderboard button
    self.leaderboards = [SKLabelNode labelNodeWithFontNamed:@"Avenir-BlackOblique"];
    self.leaderboards.text = @"Leaderboards";
    self.leaderboards.fontSize = 50;
    self.leaderboards.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.leaderboards.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-15);
    
    // reset button
    self.reset = [SKLabelNode labelNodeWithFontNamed:@"Avenir-BlackOblique"];
    self.reset.text = @"Reset Game";
    self.reset.fontSize = 50;
    self.reset.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.reset.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 75);
    
    SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
    title.fontSize = 50;
    title.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 150);
    title.text = @"BLOCK CLICKER";
    
    // Add everything
    [self addChild:title];
    [self addChild:self.play];
    [self addChild:self.leaderboards];
    [self addChild:self.reset];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if ([self.play containsPoint:location]) {
            GameScene *game = [[GameScene alloc] initWithSize:self.size];
            [self.view presentScene:game transition:[SKTransition pushWithDirection:SKTransitionDirectionUp duration:2]];
        }else if ([self.leaderboards containsPoint:location]) {
            
        } else if ([self.reset containsPoint:location]) {
            [[GameDataHelper sharedGameData] reset];
            GameScene *game = [[GameScene alloc] initWithSize:self.size];
            [self.view presentScene:game transition:[SKTransition pushWithDirection:SKTransitionDirectionUp duration:2]];

        }
    }
}

@end
