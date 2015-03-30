//
//  ShopScene.m
//  Block Clicker
//
//  Created by Luke Copeland on 3/28/15.
//  Copyright (c) 2015 Travis McMahon. All rights reserved.
//

#import "ShopScene.h"


@interface ShopScene()
@property SKSpriteNode *background;
@property SKLabelNode *backButton;
@property SKSpriteNode *ground;

@property SKLabelNode *gold;
@property int currentGold;

@end

@implementation ShopScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    // Background
    self.background = [SKSpriteNode spriteNodeWithImageNamed:@"colored_grass"];
    self.background.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    //Simple Labels
    SKLabelNode *play = [SKLabelNode labelNodeWithFontNamed:@"Avenir-BlackOblique"];
    play.text = @"Shop";
    play.fontSize = 50;
    play.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    play.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 290);
    
    self.currentGold = [GameDataHelper sharedGameData].gold;
    self.gold = [SKLabelNode labelNodeWithFontNamed:@"Avenir-BlackOblique"];
    self.gold.text = [NSString stringWithFormat:@"Gold %d", self.currentGold];
    self.gold.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.gold.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 255);
    
    // Ground
    self.ground = [SKSpriteNode spriteNodeWithImageNamed:@"grass"];
    self.ground.anchorPoint = CGPointMake(0, 0);
    self.ground.position = CGPointMake(-10, -10);
    self.ground.size = CGSizeMake(self.frame.size.width+25, self.ground.size.height);
    self.ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.ground.size.width*2, self.ground.size.height*2)];
    self.ground.physicsBody.friction = 1.0;
    self.ground.physicsBody.dynamic = NO;
    
    //Back button
    self.backButton = [SKLabelNode labelNodeWithFontNamed:@"Avenir-BlackOblique"];
    self.backButton.text = @"Back";
    self.backButton.fontSize = 40;
    self.backButton.fontColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    self.backButton.position = CGPointMake(50, 10);
    
    // Add everything
    [self addChild:self.background];
    [self addChild:self.ground];
    [self addChild:self.backButton];
    [self addChild:self.gold];
    [self addChild:play];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if ([self.backButton containsPoint:location]) {
            [GameDataHelper sharedGameData].gold = self.currentGold;
            [[GameDataHelper sharedGameData]save];
            GameScene *game = [[GameScene alloc] initWithSize:self.size];
            [self.view presentScene:game transition:[SKTransition pushWithDirection:SKTransitionDirectionRight duration:1]];
        }
    }
    
    [self touchesMoved:touches withEvent:event];
}

@end
