//
//  ShopScene.m
//  Block Clicker
//
//  Created by Luke Copeland on 3/28/15.
//  Copyright (c) 2015 Travis McMahon. All rights reserved.
//

#import "ShopScene.h"
#define FONT @"Avenir-BlackOblique"

@interface ShopScene()
@property SKSpriteNode *background;
@property SKLabelNode *backButton;
@property SKSpriteNode *ground;

@property SKLabelNode *gold;
@property int currentGold;

@property int numCoins;
@property int coinWorth;
@property int multipleCoins;

@property SKLabelNode *numberOfCoinsButton;
@property SKLabelNode *coinWorthButton;
@property SKLabelNode *multipleCoinLable;

@property SKLabelNode *pickup;
@property SKLabelNode *shooter;
@end

@implementation ShopScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    // Background
    self.background = [SKSpriteNode spriteNodeWithImageNamed:@"colored_grass"];
    self.background.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    //Simple Labels
    SKLabelNode *play = [SKLabelNode labelNodeWithFontNamed:FONT];
    play.text = @"Shop";
    play.fontSize = 50;
    play.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    play.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 290);
    
    self.currentGold = [GameDataHelper sharedGameData].gold;
    self.gold = [SKLabelNode labelNodeWithFontNamed:FONT];
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
    
    
    // 'power ups'
    self.numCoins = [GameDataHelper sharedGameData].numCoinsAllowed;
    self.coinWorth = [GameDataHelper sharedGameData].coinWorth;
    self.multipleCoins = [GameDataHelper sharedGameData].multipleCoins;
    
    self.numberOfCoinsButton = [SKLabelNode labelNodeWithFontNamed:FONT];
    self.numberOfCoinsButton.fontSize = 20;
    self.numberOfCoinsButton.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.numberOfCoinsButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 140);
    self.numberOfCoinsButton.text = [NSString stringWithFormat:@"Increase Coins to %d Cost:%d", self.numCoins*2, self.numCoins*4];

    self.coinWorthButton = [SKLabelNode labelNodeWithFontNamed:FONT];
    self.coinWorthButton.fontSize = 20;
    self.coinWorthButton.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.coinWorthButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 100);
    self.coinWorthButton.text = [NSString stringWithFormat:@"Increase Coins worth to %d Cost:%d", self.coinWorth+1, (self.coinWorth*self.coinWorth*500)];
    
    self.multipleCoinLable = [SKLabelNode labelNodeWithFontNamed:FONT];
    self.multipleCoinLable.fontSize = 20;
    self.multipleCoinLable.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.multipleCoinLable.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 60);
    self.multipleCoinLable.text = [NSString stringWithFormat:@"Increase Coins Per Click to %d Cost:%d", self.multipleCoins+1, self.multipleCoins*50];
    
    //Back button
    self.backButton = [SKLabelNode labelNodeWithFontNamed:FONT];
    self.backButton.text = @"Back";
    self.backButton.fontSize = 40;
    self.backButton.fontColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    self.backButton.position = CGPointMake(50, 10);
    
    // Add everything
    [self addChild:self.background];
    [self addChild:self.ground];
    [self addChild:self.backButton];
    [self addChild:self.gold];
    [self addChild:self.numberOfCoinsButton];
    [self addChild:self.coinWorthButton];
    [self addChild:self.multipleCoinLable];
    [self addChild:play];
    
    if (![GameDataHelper sharedGameData].pickup) {
        self.pickup = [SKLabelNode labelNodeWithFontNamed:FONT];
        self.pickup.fontSize = 20;
        self.pickup.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        self.pickup.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 20);
        self.pickup.text = [NSString stringWithFormat:@"Buy a coin collector Cost:%d", 1];
        [self addChild:self.pickup];
    }
    
    if (![GameDataHelper sharedGameData].shooter) {
        self.shooter = [SKLabelNode labelNodeWithFontNamed:FONT];
        self.shooter.fontSize = 20;
        self.shooter.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        self.shooter.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 20);
        self.shooter.text = [NSString stringWithFormat:@"Buy a coin shooter Cost:%d", 1];
        [self addChild:self.shooter];
    }
}

-(void) save {
    [GameDataHelper sharedGameData].gold = self.currentGold;
    [GameDataHelper sharedGameData].numCoinsAllowed = self.numCoins;
    [GameDataHelper sharedGameData].coinWorth = self.coinWorth;
    [GameDataHelper sharedGameData].multipleCoins = self.multipleCoins;
    [GameDataHelper sharedGameData].doorTransition = 1;
    [[GameDataHelper sharedGameData]save];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if ([self.backButton containsPoint:location]) {
            [self save];
            DoorTransition *door = [[DoorTransition alloc] initWithSize:self.size];
            [self.view presentScene:door transition:[SKTransition doorsCloseHorizontalWithDuration:1]];
        }
    }
    
    [self touchesMoved:touches withEvent:event];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if ([self.coinWorthButton containsPoint:location]) {
            //self.coinWorth+1, self.coinWorth*500
            if (self.currentGold >= self.coinWorth*self.coinWorth*500) {
                self.currentGold -= self.coinWorth*self.coinWorth*500;
                self.gold.text = [NSString stringWithFormat:@"Gold %d", self.currentGold];
                self.coinWorth++;
                self.coinWorthButton.text = [NSString stringWithFormat:@"Increase Coins worth to %d Cost:%d", self.coinWorth+1, self.coinWorth*self.coinWorth*500];
                [self save];
            }
        }
        
        if ([self.numberOfCoinsButton containsPoint:location]) {
            if (self.currentGold >= self.numCoins*4) {
                self.currentGold -= self.numCoins * 4;
                self.gold.text = [NSString stringWithFormat:@"Gold %d", self.currentGold];
                self.numCoins *= 2;
                self.numberOfCoinsButton.text = [NSString stringWithFormat:@"Increase Coins to %d Cost:%d", self.numCoins*2, self.numCoins*4];
                [self save];
            }
        }
        
        if ([self.multipleCoinLable containsPoint:location]) {
            if (self.currentGold >= self.multipleCoins*50) {
                self.currentGold -= self.multipleCoins*50;
                self.gold.text = [NSString stringWithFormat:@"Gold %d", self.currentGold];
                self.multipleCoins++;
                self.multipleCoinLable.text = [NSString stringWithFormat:@"Increase Coins Per Click to %d Cost:%d", self.multipleCoins+1, self.multipleCoins*50];
                [self save];

            }
        }
        
        if ([self.pickup containsPoint:location]) {
            if (self.currentGold >= 1) {
                self.currentGold -= 1;
                self.gold.text = [NSString stringWithFormat:@"Gold %d", self.currentGold];
                [GameDataHelper sharedGameData].pickup = true;
                [self.pickup removeFromParent];
                [self save];
                
            }
        }
        
        if ([self.shooter containsPoint:location]) {
            if (self.currentGold >= 1) {
                self.currentGold -= 1;
                self.gold.text = [NSString stringWithFormat:@"Gold %d", self.currentGold];
                [GameDataHelper sharedGameData].shooter = true;
                [self.shooter removeFromParent];
                [self save];
            }
        }
    }
}

@end
