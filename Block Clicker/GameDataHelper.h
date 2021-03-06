//
//  GameDataHelper.h
//  Block Clicker
//
//  Created by Luke Copeland on 3/28/15.
//  Copyright (c) 2015 Travis McMahon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameDataHelper : NSObject <NSCoding>
@property (assign, nonatomic) int gold;
@property (assign, nonatomic) int time;
@property (assign, nonatomic) int numCoinsAllowed;
@property (assign, nonatomic) int coinWorth;
@property (assign, nonatomic) int multipleCoins;
@property (assign, nonatomic) int doorTransition;

@property (assign, nonatomic) int blockHp;
@property (strong, nonatomic) NSMutableArray *leaderboard;

@property (assign, nonatomic) bool pickup;
@property (assign, nonatomic) bool shooter;

+(instancetype)sharedGameData;
-(void)reset;
-(void)save;
@end
