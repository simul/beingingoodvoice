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

@interface UIAudioControl : UIView
{
	NSString* soundFile;
    BOOL _trackerThumbOn;
	BOOL _running;
    float _padding;
    UIImageView * _buttonImage;
	UIImageView *_background;
	AVAudioPlayer *audioPlayer;
	CADisplayLink *displayLink;

}
@property(nonatomic) NSString* soundFile;
@end