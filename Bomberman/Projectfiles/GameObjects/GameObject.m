//
//  GameObject.m
//  Bomberman
//
//  Created by Ken on 10/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"

static const int GameObjectMovingAnimFramesCount = 4;
static const CGFloat GameObjectMovingAnimDelay = 0.2f;
static const NSInteger GameObjectMovingAnimTag = 9999;

@interface GameObject ()

@property (nonatomic, strong) NSString *animPrefix;
@property (nonatomic, assign) Direction facingDirection;

- (NSString *)animFormatWithDirection:(Direction)direction;
- (int)animFirstIndexWithDirection:(Direction)direction;

@end

@implementation GameObject

@synthesize animPrefix = _animPrefix;
@synthesize facingDirection = _facingDirection;

- (id)initWithAnimPrefix:(NSString *)prefix
{
    NSString *idleSpriteFrameName = [NSString stringWithFormat:@"%@_01", prefix];
    
    if (self = [super initWithSpriteFrameName:idleSpriteFrameName])
    {
        self.animPrefix = prefix;
        self.facingDirection = kDirectionRight;
        self.scale = 3.0f;
    }
    return self;
}

-(void) onEnter
{
	[super onEnter];
}

-(void) cleanup
{
	[super cleanup];
}

-(void) dealloc
{
	NSLog(@"dealloc: %@", self);
}

-(void) update:(ccTime)delta
{
    
}

- (NSString *)animFormatWithDirection:(Direction)direction
{   
    NSString *animFormat = [NSString stringWithFormat:@"%@_%@", self.animPrefix, @"%.2i"];
    
    return animFormat;
}

- (int)animFirstIndexWithDirection:(Direction)direction
{
    switch (direction) {
        case kDirectionLeft:
            return 5;
            
        case kDirectionRight:
            return 9;
            
        case kDirectionUp:
            return 13;
            
        case kDirectionDown:
            return 1;
    }
}

- (void)setFacingDirection:(Direction)facingDirection
{
    if (self.facingDirection != facingDirection)
    {
        _facingDirection = facingDirection;
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:[self animFormatWithDirection:facingDirection], [self animFirstIndexWithDirection:facingDirection]]];
    }
}

- (void)playMovingAnimWithDirection:(Direction)direction
{   
    [self playAnimLoopedWithFormat:[self animFormatWithDirection:direction] numFrames:GameObjectMovingAnimFramesCount firstIndex:[self animFirstIndexWithDirection:direction] delay:GameObjectMovingAnimDelay animateTag:GameObjectMovingAnimTag restoreOriginalFrame:YES];
}

- (void)stopMovingAnimation
{
    [self stopActionByTag:GameObjectMovingAnimTag];
}

@end
