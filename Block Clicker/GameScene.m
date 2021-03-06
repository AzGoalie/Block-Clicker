//
//  GameScene.m
//  Block Clicker
//
//  Created by Travis McMahon on 3/25/15.
//  Copyright (c) 2015 Travis McMahon. All rights reserved.
//

#import "GameScene.h"
#define ARC4RANDOM_MAX 0x100000000
#define COIN_CATEGORY 0x1 << 0
#define BOUNDS_CATEGORY 0x1 << 1

#define COIN_ACCELERATION 1000
#define FONT @"Avenir-BlackOblique"

@interface GameScene()
@property SKSpriteNode *block;
@property SKSpriteNode *ground;
@property SKSpriteNode *background;

@property NSTimer *timer;
@property int currTimeInSec;
@property SKLabelNode *time;

@property SKLabelNode *gold;
@property int currentGold;

@property SKLabelNode *backButton;
@property SKLabelNode *shopButton;

@property SKLabelNode *coinTotal;
@property int numCoins;
@property int coinsOut;
@property int coinWorth;
@property int multipleCoins;

@property int hp;
@property SKLabelNode *hpLabel;

@property SKSpriteNode *pickup;
@property SKSpriteNode *shooter;
@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    
    /* Setup your scene here */
    // Background
    self.background = [SKSpriteNode spriteNodeWithImageNamed:@"colored_grass"];
    self.background.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    // Coinbox
    self.block = [SKSpriteNode spriteNodeWithImageNamed:@"box"];
    self.block.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self.block setScale:0.5];
    
    // Ground
    self.ground = [SKSpriteNode spriteNodeWithImageNamed:@"grass"];
    self.ground.anchorPoint = CGPointMake(0, 0);
    self.ground.position = CGPointMake(-10, -10);
    self.ground.size = CGSizeMake(self.frame.size.width+25, self.ground.size.height);
    self.ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.ground.size.width*2, self.ground.size.height*2)];
    self.ground.physicsBody.friction = 1.0;
    self.ground.physicsBody.dynamic = NO;
    
    // Font color
    SKColor *color =[SKColor colorWithWhite:0.5 alpha:1.0];
    
    // Timer
    self.time = [SKLabelNode labelNodeWithFontNamed:FONT];
    self.time.fontColor = color;
    self.time.text = @"00:00:00";
    self.time.fontSize = 40;
    self.time.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 300);
    self.timer = [self createTimer];
    self.currTimeInSec =[GameDataHelper sharedGameData].time;
    [self.timer fire];
    
    // Money/Score
    self.currentGold = [GameDataHelper sharedGameData].gold;
    self.gold = [SKLabelNode labelNodeWithFontNamed:FONT];
    self.gold.text = [NSString stringWithFormat:@"Gold %d", self.currentGold];
    self.gold.fontColor = color;
    self.gold.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 275);
    
    // HP
    self.hp = [GameDataHelper sharedGameData].blockHp;
    self.hpLabel = [SKLabelNode labelNodeWithFontNamed:FONT];
    self.hpLabel.text = [NSString stringWithFormat:@"Block HP: %d", self.hp];
    self.hpLabel.fontColor = color;
    self.hpLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 225);
    
    self.coinsOut = 0;
    self.coinTotal = [SKLabelNode labelNodeWithFontNamed:FONT];
    self.coinTotal.fontColor = color;
    self.numCoins = [GameDataHelper sharedGameData].numCoinsAllowed;
    self.coinWorth = [GameDataHelper sharedGameData].coinWorth;
    
    self.multipleCoins = [GameDataHelper sharedGameData].multipleCoins;
    
    self.coinTotal.text = [NSString stringWithFormat:@"Coins: %d/%d", self.coinsOut, self.numCoins];
    self.coinTotal.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 250);
    
    // Buttons
    self.backButton = [SKLabelNode labelNodeWithFontNamed:FONT];
    self.backButton.text = @"Main Menu";
    self.backButton.fontSize = 40;
    self.backButton.fontColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    self.backButton.position = CGPointMake(10, 10);
    
    self.shopButton = [SKLabelNode labelNodeWithFontNamed:FONT];
    self.shopButton.text = @"Shop";
    self.shopButton.fontSize = 40;
    self.shopButton.fontColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    self.shopButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    self.shopButton.position = CGPointMake(self.view.frame.size.width - 10, 10);
    
    // Add everything
    [self addChild:self.background];
    [self addChild:self.block];
    [self addChild:self.ground];
    [self addChild:self.time];
    [self addChild:self.gold];
    [self addChild:self.backButton];
    [self addChild:self.shopButton];
    [self addChild:self.coinTotal];
    [self addChild:self.hpLabel];
    
    if ([GameDataHelper sharedGameData].shooter) {
        self.shooter = [SKSpriteNode spriteNodeWithImageNamed:@"shooter"];
        self.shooter.anchorPoint = CGPointMake(0, 0);
        self.shooter.position = CGPointMake(0, self.ground.size.height-10);
        self.shooter.size = CGSizeMake(self.pickup.size.width/2, self.pickup.size.height/2);

        
        [NSTimer scheduledTimerWithTimeInterval:1.0f
                                         target:self selector:@selector(spawnCoin2:) userInfo:nil repeats:YES];
        
        [self addChild:self.shooter];
    }
    
    if ([GameDataHelper sharedGameData].pickup) {
        self.pickup = [SKSpriteNode spriteNodeWithImageNamed:@"pickup"];
        self.pickup.anchorPoint = CGPointMake(0, 0);
        self.pickup.position = CGPointMake(0, self.ground.size.height-10);
        self.pickup.size = CGSizeMake(self.pickup.size.width/2, self.pickup.size.height/2);
        
        SKAction *a = [SKAction sequence:@[
                                          [SKAction moveTo:CGPointMake(self.size.width, self.pickup.position.y) duration:1],
                                          [SKAction scaleXTo:-1 duration:0.5],
                                          [SKAction moveTo:CGPointMake(0, self.pickup.position.y) duration:1],
                                          [SKAction scaleXTo:1 duration:0.5]
                                          ]];
        [self.pickup runAction:[SKAction repeatActionForever:a]];
        
        [self addChild:self.pickup];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if ([self.backButton containsPoint:location]) {
            [self pickUpCoins];
            MainMenuScene *menu = [[MainMenuScene alloc] initWithSize:self.size];
            [self.view presentScene:menu transition:[SKTransition pushWithDirection:SKTransitionDirectionDown duration:.5]];
        }else if ([self.shopButton containsPoint:location]){
            [self pickUpCoins];
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
        
        if ([self.block containsPoint:location] && self.coinsOut < self.numCoins) {
            for (int i = 0; i < self.multipleCoins && self.coinsOut < self.numCoins; i++)
                [self spawnCoin];
        }
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        [self enumerateChildNodesWithName:@"coin" usingBlock:^(SKNode *node, BOOL *stop) {
            if ([node containsPoint:location] && ![self.block containsPoint:location]) {
                self.currentGold += self.coinWorth;
                self.coinsOut--;
                self.coinTotal.text = [NSString stringWithFormat:@"Coins: %d/%d", self.coinsOut, self.numCoins];
                [self updateGold];
                [node removeFromParent];
            }
        }];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    // Pickuper
    [self enumerateChildNodesWithName:@"coin" usingBlock:^(SKNode *node, BOOL *stop) {
        if ([node containsPoint:self.pickup.position]) {
            self.currentGold += self.coinWorth;
            self.coinsOut--;
            self.coinTotal.text = [NSString stringWithFormat:@"Coins: %d/%d", self.coinsOut, self.numCoins];
            [self updateGold];
            [node removeFromParent];
        }
    }];

    // Shooter
}

- (NSTimer*) createTimer {
    return [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeTicked:) userInfo:nil repeats:YES];
}

- (void) timeTicked:(NSTimer*)timer {
    self.currTimeInSec++;
    self.time.text = [self formattedTime: self.currTimeInSec];
}

- (NSString *) formattedTime:(int)time {
    int sec = time % 60;
    int min = (time / 60) % 60;
    int hour = time / 3600;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, min, sec];
}

-(void) spawnCoin {
    SKSpriteNode *coin = [SKSpriteNode spriteNodeWithImageNamed:@"coin"];
    coin.name = @"coin";
    [coin setScale:0.5];
    
    coin.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:coin.size.width/2];
    coin.physicsBody.dynamic = YES;
    coin.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    double min = -0.785398163;
    double max = 0.785398163;
    double val = ((double)arc4random() / ARC4RANDOM_MAX) * (max - min) + min;
    
    coin.physicsBody.velocity = CGVectorMake(sin(val)*COIN_ACCELERATION, cos(val)*COIN_ACCELERATION);
    
    coin.physicsBody.linearDamping = 1.0;
    coin.physicsBody.categoryBitMask = COIN_CATEGORY;
    coin.physicsBody.collisionBitMask = BOUNDS_CATEGORY;
    
    self.coinsOut++;
    self.coinTotal.text = [NSString stringWithFormat:@"Coins: %d/%d", self.coinsOut, self.numCoins];
    
    self.hp -= self.coinWorth;
    self.hpLabel.text = [NSString stringWithFormat:@"Block HP: %d", self.hp];
    
    // GAME OVER
    if (self.hp <= 0) {
        [self pickUpCoins];
        [self save];
        GameOverScene *go = [[GameOverScene alloc] initWithSize:self.size];
        [self.view presentScene:go transition:[SKTransition pushWithDirection:SKTransitionDirectionDown duration:2]];
    }
    
    [self addChild:coin];
}

- (void) spawnCoin2:(NSTimer *)timer {
    [self spawnCoin];
}

-(void) updateGold {
    self.gold.text = [NSString stringWithFormat:@"Gold %d", self.currentGold];
}

-(void) pickUpCoins {
    [self enumerateChildNodesWithName:@"coin" usingBlock:^(SKNode *node, BOOL *stop) {
        self.currentGold += self.coinWorth;
        [self updateGold];
        [node removeFromParent];
    }];
    self.coinsOut = 0;
    [self save];
}

-(void) save {
    [GameDataHelper sharedGameData].gold = self.currentGold;
    [GameDataHelper sharedGameData].time = self.currTimeInSec;
    [GameDataHelper sharedGameData].coinWorth = self.coinWorth;
    [GameDataHelper sharedGameData].numCoinsAllowed = self.numCoins;
    [GameDataHelper sharedGameData].multipleCoins = self.multipleCoins;
    [GameDataHelper sharedGameData].doorTransition = 0;
    [GameDataHelper sharedGameData].blockHp = self.hp;

    [[GameDataHelper sharedGameData]save];

}

@end
