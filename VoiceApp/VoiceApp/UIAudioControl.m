//
//  UIAudioControl.m
//  VoiceApp
//
//  Created by Flloyd Pauline Kennedy on 6/01/13.
//  Copyright (c) 2013 Flloyd Pauline Kennedy. All rights reserved.
//

#import "UIAudioControl.h"

@implementation UIAudioControl

@synthesize soundFile;
-(void)baseInit
{
	_running=false;
	// Initialization code
	_trackerThumbOn = false;
	_padding = 20; // 20 is a good value
	
	//_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar-background.png"]];
	//_background.frame = CGRectMake((frame.size.width - _background.frame.size.width) / 2, (frame.size.height - _background.frame.size.height) / 2, _background.frame.size.width, _background.frame.size.height);
	//[self addSubview:_background];
	//_buttonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play.png"]] ;
	//	[self addSubview:_track];_minThumb = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"handle.png"] highlightedImage:[UIImage imageNamed:@"handle-hover.png"]] autorelease];
	//_buttonImage.center =self.center;
	//[self addSubview:_buttonImage];
	// The audio player
	
	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/alignment.mp3", [[NSBundle mainBundle] resourcePath]]];
	
	NSError *error;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	if (audioPlayer == nil)
		NSLog(@"Failed to create audio player");
	else
		audioPlayer.numberOfLoops = -1;
	
	displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)] ;
	
}
-(id)initWithCoder:(NSCoder*)coder
{
    self = [super initWithCoder:coder];
    if (self)
	{
		[self baseInit];
	}
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		[self baseInit];
	}
    return self;
}

-(IBAction)playAudio
{
	CFBundleRef mainBundle=CFBundleGetMainBundle();
	CFURLRef audioRef=CFBundleCopyResourceURL(mainBundle,(CFStringRef) @"alignment",CFSTR("mp3"),NULL);
	if(audioPlayer!=nil)
	{
		if(![audioPlayer isPlaying])
			[audioPlayer play];
		else
			[audioPlayer pause];
		

		//[playButton setImage:((audioPlayer.playing == YES) ? pauseBtnBG : playBtnBG) forState:UIControlStateNormal];
	}
	/*
	 audioPlayer.volume = 0.5; // 0.0 - no volume; 1.0 full volume
	 NSLog(@"%f seconds played so far", audioPlayer.currentTime);
	 audioPlayer.currentTime = 10; // jump to the 10 second mark
	 [audioPlayer stop]; /
	 */
}
// Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
	if (!_running)
	{
		[displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
		_running = YES;
	}
	[super drawRect:rect];

	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetFillColorWithColor( context, [UIColor blueColor].CGColor );
	CGRect subrect=rect;
	subrect.size.height=20;
    //CGContextFillRect( context, subrect );
    // Drawing code
	CGFloat	pi=3.1415926536;
	CGFloat angle=pi*2.0*audioPlayer.currentTime/10.0;
	CGFloat inner_radius=30;
	CGFloat outer_radius=40;
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGFloat mid_x=rect.size.width/2;
	CGFloat mid_y=rect.size.height/2;
	// Add the outer arc to the path (as if you wanted to fill the entire circle)
	//CGPathMoveToPoint(path,NULL,mid_x,mid_y+outer_radius);
	CGPathAddArc(path,NULL,mid_x,mid_y,outer_radius,-pi/2.0,-pi/2.0+angle,NO);
	//CGPathMoveToPoint(path,NULL,angle_x,angle_y);
	CGPathAddArc(path,NULL,mid_x,mid_y,inner_radius,-pi/2.0+angle,-pi/2.0,YES);
	CGPathMoveToPoint(path,NULL,mid_x,mid_y+inner_radius);
	//CGPathMoveToPoint(path,NULL,mid_x,mid_y);
	//CGPathMoveToPoint(path,NULL,mid_x,mid_y+inner_radius);
	//CGPathMoveToPoint(path,NULL,mid_x,mid_y+outer_radius);
	CGPathCloseSubpath(path);
	
	// Add the inner arc to the path (later used to substract the inner area)
	//CGPathMoveToPoint(path,NULL,mid_x,mid_y+inner_radius);
	////CGPathAddArc(path,NULL,mid_x,mid_y,inner_radius,0,angle,true);
	//CGPathCloseSubpath(path);
	
	// Add the path to the context
	CGContextAddPath(context, path);
	
	// Fill the path using the even-odd fill rule
	CGContextFillPath(context);
} 

@end
