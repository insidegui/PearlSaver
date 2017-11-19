//
//  PearlSaverView.m
//  PearlSaver
//
//  Created by Guilherme Rambo on 18/11/17.
//  Copyright © 2017 Guilherme Rambo. All rights reserved.
//

#import "PearlSaverView.h"

@import AVFoundation;

@interface PearlSaverView ()

@property (nonatomic, strong) AVQueuePlayer *player;
@property (nonatomic, strong) AVPlayerLooper *looper;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation PearlSaverView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    
    [self setAnimationTimeInterval:1/30.0];
    
    return self;
}

- (NSURL *)_pearlVideoURL
{
    return [[NSBundle bundleForClass:[self class]] URLForResource:@"Pearl" withExtension:@"mp4"];
}

- (void)_installAndStartPlayer
{
    if (!self.player) {
        self.wantsLayer = YES;
        self.layer = [CALayer layer];
        self.layer.backgroundColor = [[NSColor blackColor] CGColor];
        
        self.player = [AVQueuePlayer new];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[self _pearlVideoURL]];
        self.looper = [AVPlayerLooper playerLooperWithPlayer:self.player templateItem:item];
        
        [self.layer addSublayer:self.playerLayer];
        
        [self _resizePearlLayer];
    }
    
    [self.player play];
}

- (void)_stopPlayer
{
    [self.player pause];
}

- (void)_resizePearlLayer
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationDuration:0];
    self.playerLayer.frame = self.bounds;
    [CATransaction commit];
}

- (void)layout
{
    [super layout];
    
    [self _resizePearlLayer];
}

- (void)startAnimation
{
    [super startAnimation];
    
    [self _installAndStartPlayer];
}

- (void)stopAnimation
{
    [super stopAnimation];
    
    [self _stopPlayer];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
