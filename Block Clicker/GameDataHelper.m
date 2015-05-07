//
//  GameDataHelper.m
//  Block Clicker
//
//  Created by Luke Copeland on 3/28/15.
//  Copyright (c) 2015 Travis McMahon. All rights reserved.
//

#import "GameDataHelper.h"

@implementation GameDataHelper
static NSString * const goldKey = @"gold";
static NSString * const timeKey = @"time";
static NSString * const numCoinKey = @"nCoins";
static NSString * const coinWothKey = @"coinWorth";
static NSString * const multipleCoinsKey = @"multipleCoins";
static NSString * const doorTransition = @"doorTransition";

static NSString * const lbKey = @"leaderboard";
static NSString * const blockHpKey = @"blockHp";
static NSString * const pickupKey = @"pickup";
static NSString * const shooterKey = @"shooter";

+(instancetype)sharedGameData {
    static id sharedInstance = nil;
    if (sharedInstance == nil)
        sharedInstance = [GameDataHelper loadInstance];
    
    return sharedInstance;
}

-(void)reset{
    self.gold = 0; //Set Gold and time back to zero, new game
    self.time = 0;
    self.numCoinsAllowed = 25;
    self.coinWorth = 1;
    self.multipleCoins = 1;
    self.doorTransition = 0;
    self.blockHp = 1000;
    self.leaderboard = [[NSMutableArray alloc] init];
    self.pickup = false;
    self.shooter = false;
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeDouble:self.gold forKey:goldKey];
    [encoder encodeDouble:self.time forKey:timeKey];
    [encoder encodeInt:self.numCoinsAllowed forKey:numCoinKey];
    [encoder encodeInt:self.coinWorth forKey:coinWothKey];
    [encoder encodeInt:self.multipleCoins forKey:multipleCoinsKey];
    [encoder encodeInt:self.doorTransition forKey:doorTransition];
    [encoder encodeInt:self.blockHp forKey:blockHpKey];
    [encoder encodeBool:self.pickup forKey:pickupKey];
    [encoder encodeBool:self.shooter forKey:shooterKey];
}
-(instancetype)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if(self){
        _gold = [decoder decodeDoubleForKey:goldKey];
        _time = [decoder decodeDoubleForKey:timeKey];
        _numCoinsAllowed = [decoder decodeIntForKey:numCoinKey];
        _coinWorth = [decoder decodeIntForKey:coinWothKey];
        _multipleCoins = [decoder decodeIntForKey:multipleCoinsKey];
        _doorTransition = [decoder decodeIntForKey:doorTransition];
        _blockHp = [decoder decodeIntForKey:blockHpKey];
        _leaderboard = [decoder decodeObjectForKey:lbKey];
        _pickup = [decoder decodeBoolForKey:pickupKey];
        _shooter = [decoder decodeBoolForKey:shooterKey];
    }
    return self;
}

+(instancetype)loadInstance{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *archivePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"archive"];
    GameDataHelper *gameHelper = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
    if (gameHelper == nil) {
        gameHelper = [[GameDataHelper alloc] init];
        [gameHelper reset];
    }
    
    return gameHelper;
}

-(void)save {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *archivePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"archive"];
    [NSKeyedArchiver archiveRootObject:self toFile:archivePath];
}

@end
