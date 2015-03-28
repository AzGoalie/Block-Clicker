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
    
    SKLabelNode *play = [SKLabelNode labelNodeWithFontNamed:@"Avenir-BlackOblique"];
    play.text = @"Click To Play!";
    play.fontSize = 50;
    play.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    play.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 50);
    
    // Add everything
    [self addChild:play];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    GameScene *game = [[GameScene alloc] initWithSize:self.size];
    [self.view presentScene:game transition:[SKTransition pushWithDirection:SKTransitionDirectionUp duration:1]];
}

@end
