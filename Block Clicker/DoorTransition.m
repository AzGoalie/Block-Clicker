//
//  DoorTransition.m
//  Block Clicker
//
//  Created by Luke Copeland on 3/30/15.
//  Copyright (c) 2015 Travis McMahon. All rights reserved.
//

#import "DoorTransition.h"
@interface DoorTransition()
@property NSTimer *timer;
@property int currTimeInSec;
@property SKLabelNode *time;

@property int doorBool;
@end

@implementation DoorTransition

-(void)didMoveToView:(SKView *)view
{
    //Set up background
    self.backgroundColor = [UIColor colorWithRed:0.816 green:0.957 blue:0.969 alpha:1.0];
    
    //Set doorBool, Lets DoorTranstionScence know which scene to transition to
    self.doorBool = [GameDataHelper sharedGameData].doorTransition;
    
    //Create timer to transition to shop
    self.timer = [self createTimer];
    self.currTimeInSec = 0;
    [self.timer fire];
    
}

- (NSTimer*) createTimer {
    return [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeTicked:) userInfo:nil repeats:YES];
}

- (void) timeTicked:(NSTimer*)timer {
    if(self.currTimeInSec == 1){
        if(self.doorBool == 0){
            ShopScene *shop = [[ShopScene alloc] initWithSize:self.size];
            [self.view presentScene:shop transition:[SKTransition doorsOpenHorizontalWithDuration:1]];
            [self.timer invalidate];
        }else if(self.doorBool ==1){
            GameScene *game = [[GameScene alloc] initWithSize:self.size];
            [self.view presentScene:game transition:[SKTransition doorsOpenHorizontalWithDuration:1]];
            [self.timer invalidate];
        }
    }
    self.currTimeInSec++;
}


@end
