//
//  GameOverScene.m
//  Block Clicker
//
//  Created by Travis McMahon on 5/6/15.
//  Copyright (c) 2015 Travis McMahon. All rights reserved.
//

#import "GameOverScene.h"

@implementation GameOverScene

-(void)didMoveToView:(SKView *)view {
    // Background
    self.backgroundColor = [UIColor colorWithRed:0.816 green:0.957 blue:0.969 alpha:1.0];
    
    // Title
    SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Avenir-BlackOblique"];
    title.fontSize = 50;
    title.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 250);
    title.text = @"You Win!";
    
    // OK Button
    self.ok = [SKLabelNode labelNodeWithFontNamed:@"Avenir-BlackOblique"];
    self.ok.fontSize = 50;
    self.ok.fontColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.ok.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 150);
    self.ok.text = @"Submit Score";
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(self.size.width/2, self.size.height/2+20, 200, 40)];
    self.textField.center = self.view.center;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.textColor = [UIColor blackColor];
    self.textField.font = [UIFont systemFontOfSize:17.0];
    self.textField.placeholder = @"Enter your name here";
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.autocorrectionType = UITextAutocorrectionTypeYes;
    self.textField.keyboardType = UIKeyboardTypeDefault;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    [self addChild:title];
    [self addChild:self.ok];
}

-(void) willMoveFromView:(SKView *)view {
    [self.textField removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textField) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if ([self.ok containsPoint:location]) {
            // Record/save name
            [[GameDataHelper sharedGameData].leaderboard addObject:[NSString stringWithFormat:@"%@\t\t%d",self.textField, [GameDataHelper sharedGameData].time]];
            [[GameDataHelper sharedGameData] save];
            
            LeaderboardScene *game = [[LeaderboardScene alloc] initWithSize:self.size];
            [self.view presentScene:game transition:[SKTransition pushWithDirection:SKTransitionDirectionDown duration:2]];
        }
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

@end
