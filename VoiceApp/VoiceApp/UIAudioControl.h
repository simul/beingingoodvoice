//
//  UIAudioControl.h
//  VoiceApp
//
//  Created by Flloyd Pauline Kennedy on 6/01/13.
//  Copyright (c) 2013 Flloyd Pauline Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAudioControl : UIView
{
	NSString* soundFile;
    BOOL _trackerThumbOn;
    float _padding;
    UIImageView * _buttonImage;
	UIImageView *_background;
}
@property(nonatomic) NSString* soundFile;
@end