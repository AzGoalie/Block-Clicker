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

+(instancetype)sharedGameData {
    static id sharedInstance = nil;
    if (sharedInstance == nil)
        sharedInstance = [GameDataHelper loadInstance];
    
    return sharedInstance;
}

-(void)reset{
    self.gold = 0; //Set Gold and time back to zero, new game
    self.time = 0;
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeDouble:self.gold forKey:goldKey];
    [encoder encodeDouble:self.time forKey:timeKey];
    
}
-(instancetype)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if(self){
        _gold = [decoder decodeDoubleForKey:goldKey];
        _time = [decoder decodeDoubleForKey:timeKey];
    }
    return self;
}

+(instancetype)loadInstance{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *archivePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"archive"];
    GameDataHelper *gameHelper = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
    if (gameHelper == nil)
        gameHelper = [[GameDataHelper alloc] init];
    
    return gameHelper;
}

-(void)save {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *archivePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"archive"];
    [NSKeyedArchiver archiveRootObject:self toFile:archivePath];
}

@end
