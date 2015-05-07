//
//  LeaderboardScene.m
//  Block Clicker
//
//  Created by Travis McMahon on 5/6/15.
//  Copyright (c) 2015 Travis McMahon. All rights reserved.
//

#import "LeaderboardScene.h"

@implementation LeaderboardScene

-(void)didMoveToView:(SKView *)view {
    // Background
    self.backgroundColor = [UIColor colorWithRed:0.816 green:0.957 blue:0.969 alpha:1.0];
    
    // Title
    SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Avenir-BlackOblique"];
    title.fontSize = 50;
    title.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 250);
    title.text = @"Leaderboards";
    
    // back button
    self.back = [SKLabelNode labelNodeWithFontNamed:@"Avenir-BlackOblique"];
    self.back.text = @"back";
    self.back.fontSize = 50;
    self.back.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.back.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 250);
    
    // Add everything
    [self addChild:self.back];
    [self addChild:title];
    
    for (int i = 0; i < [GameDataHelper sharedGameData].leaderboard.count; i++) {
        SKLabelNode *n = [SKLabelNode labelNodeWithFontNamed:@"Avenir-BlackOblique"];
        n.fontSize = 25;
        n.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        n.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 150);
        n.text = @"asd;lka;fgljk";
        [self addChild:n];
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if ([self.back containsPoint:location]) {
            MainMenuScene *menu = [[MainMenuScene alloc] initWithSize:self.size];
            [self.view presentScene:menu transition:[SKTransition pushWithDirection:SKTransitionDirectionLeft duration:.5]];
        }
    }
}

@end
