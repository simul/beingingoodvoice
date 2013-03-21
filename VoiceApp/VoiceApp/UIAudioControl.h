//
//  UIAudioControl.h
//  VoiceApp
//
//  Created by Flloyd Pauline Kennedy on 6/01/13.
//  Copyright (c) 2013 Flloyd Pauline Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UIAudioControl.h"

@interface UIAudioControl : UIControl
{
	NSString* soundFile;
    BOOL _trackerThumbOn;
	BOOL _running;
    float _padding;
    UIImage * _playImage;
    UIImage * _pauseImage;
	UIImageView *_background;
	UIImageView *thumb;
	AVAudioPlayer *audioPlayer;
	CADisplayLink *displayLink;
	IBOutlet UIButton *button;

}

@property(nonatomic) NSString* soundFile;
@property (nonatomic, retain) UIImageView *thumb;

@property (nonatomic, retain) UIButton *button;

-(CGPoint)posForAngle:(CGFloat)angle :(CGFloat)radius;
-(CGFloat)angleForPos:(CGPoint)p;
-(void)drawFilledArc:(CGContextRef)context innerRadius:(CGFloat)inner_radius outerRadius:(CGFloat)outer_radius withAngle:(CGFloat)angle withColour:(CGColorRef)color;
-(void)stop;
@end