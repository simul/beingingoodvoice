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
@synthesize button;
@synthesize thumb;

CGFloat	pi=3.1415926536;
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
	
	displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)] ;
	_playImage = [UIImage imageNamed:@"play.png"];
	_pauseImage = [UIImage imageNamed:@"pause.png"];
	
	[self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.0]];
}
-(void)stop
{
    [audioPlayer stop];
}
- (void) setFrame:(CGRect)aFrame
{
    [super setFrame:aFrame]; // Called from initWithCoder by super. Correct frame size.
}

-(CGFloat)angleForPos:(CGPoint)p
{
	CGFloat mid_x=self.frame.size.width/2;
	CGFloat mid_y=self.frame.size.height/2;
	CGFloat dx=p.x-mid_x;
	CGFloat dy=mid_y-p.y;
	CGFloat angle=atan2f(dx,dy);
	return angle;
}

-(CGPoint)posForAngle:(CGFloat)angle :(CGFloat)radius
{
	CGFloat mid_x=self.frame.size.width/2;
	CGFloat mid_y=self.frame.size.height/2;
	return CGPointMake(mid_x+radius*sin(angle),mid_y-radius*cos(angle));
}
- (void)awakeFromNib {
	[super awakeFromNib];
	
	[button setImage:_playImage forState:UIControlStateNormal];
	[button setImage:_pauseImage forState:UIControlStateSelected];
	[button setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
	
	thumb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"handle.png"] highlightedImage:[UIImage imageNamed:@"handle-hover.png"]];

	[self addSubview:thumb];
	
	
}
-(void)setSoundFile:(NSString *)s
{
	// The audio player
	//@"%@/alignment.mp3"
	NSString *path=[s stringByAppendingString:@".mp3"];//[NSString stringWithFormat:@"%s.mp3",.cString, [[NSBundle mainBundle] resourcePath]];
	NSString *r=[[NSBundle mainBundle] resourcePath];
	r=[r stringByAppendingString:@"/"];
	path=[r stringByAppendingString:path];
	NSURL *url = [NSURL fileURLWithPath:path];
	
	NSError *error;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	audioPlayer.meteringEnabled=YES;
	if (audioPlayer == nil)
		NSLog(@"Failed to create audio player");
	else
		audioPlayer.numberOfLoops = 0;
	
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
	if(audioPlayer!=nil)
	{
		if(![audioPlayer isPlaying])
			[audioPlayer play];
		else
			[audioPlayer pause];
		

		[button setSelected:[audioPlayer isPlaying]];
		button.selected=[audioPlayer isPlaying];
	}
	/*
	 audioPlayer.volume = 0.5; // 0.0 - no volume; 1.0 full volume
	 NSLog(@"%f seconds played so far", audioPlayer.currentTime);
	 audioPlayer.currentTime = 10; // jump to the 10 second mark
	 [audioPlayer stop]; /
	 */
}

-(BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    if(CGRectContainsPoint(thumb.frame, touchPoint))
	{
        _trackerThumbOn = true;
    }
	else if(CGRectContainsPoint(thumb.frame, touchPoint))
	{
        _trackerThumbOn = true;
    }
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(!_trackerThumbOn && !_trackerThumbOn){
        return YES;
    }
    CGPoint touchPoint = [touch locationInView:self];
    if(_trackerThumbOn)
	{
		//   _thumb.center = CGPointMake(MAX([self xForValue:minimumValue],MIN(touchPoint.x, [self xForValue:selectedMaximumValue - minimumRange])), _minThumb.center.y);
		CGFloat angle=pi*2.0*audioPlayer.currentTime/audioPlayer.duration;
		CGFloat new_angle=[self angleForPos:touchPoint];
		if(angle>pi/2.0&&new_angle<0)
			new_angle+=2.0*pi;
		if(angle>pi*3.0/2.0&&new_angle<pi)
			new_angle+=2.0*pi;
		if(new_angle<0)
			new_angle=0;
		if(new_angle>2.0*pi)
			new_angle=2.0*pi;
		if(![audioPlayer isPlaying])
		{
			audioPlayer.currentTime=new_angle/pi/2.0*audioPlayer.duration;
		}
    }
    if(_trackerThumbOn)
	{
     //   _maxThumb.center = CGPointMake(MIN([self xForValue:maximumValue], MAX(touchPoint.x, [self xForValue:selectedMinimumValue + minimumRange])), _maxThumb.center.y);
    }
    [self setNeedsDisplay];
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    _trackerThumbOn = false;
}

-(void)drawFilledArc:(CGContextRef)context innerRadius:(CGFloat)inner_radius outerRadius:(CGFloat)outer_radius withAngle:(CGFloat)angle withColour:(CGColorRef)colour
{
    CGContextSetFillColorWithColor( context, colour );
	CGMutablePathRef path = CGPathCreateMutable();
	CGFloat mid_x=self.frame.size.width/2;
	CGFloat mid_y=self.frame.size.height/2;
	// Add the outer arc to the path (as if you wanted to fill the entire circle)
	CGPathAddArc(path,NULL,mid_x,mid_y,outer_radius,-pi/2.0,-pi/2.0+angle,NO);
	CGPathAddArc(path,NULL,mid_x,mid_y,inner_radius,-pi/2.0+angle,-pi/2.0,YES);
	CGPathMoveToPoint(path,NULL,mid_x,mid_y+inner_radius);
	CGPathCloseSubpath(path);
	
	// Add the path to the context
	CGContextAddPath(context, path);
	
	// Fill the path using the even-odd fill rule
	CGContextFillPath(context);
}

- (void)drawRect:(CGRect)rect
{
	if (!_running)
	{
		[displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
		_running = YES;
	}
	[super drawRect:rect];
	[audioPlayer updateMeters];

	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGRect subrect=rect;
	subrect.size.height=20;
    //CGContextFillRect( context, subrect );
    // Drawing code
	CGFloat d=audioPlayer.duration;
	if(d<=0)
		d=1000.0;
	CGFloat angle=pi*2.0*audioPlayer.currentTime/d;
	
	CGPoint p = [self posForAngle:angle:65.0];
	thumb.center=p;
	[thumb sizeToFit ];
	[thumb setHidden:[audioPlayer isPlaying]];
	
	UIColor *faintcolour=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
	[self drawFilledArc:context innerRadius:50 outerRadius:80 withAngle:2.0*pi withColour:faintcolour.CGColor];
	
	UIColor *fillcolour=[UIColor blueColor];
	[self drawFilledArc:context innerRadius:50 outerRadius:80 withAngle:angle withColour:fillcolour.CGColor];
	
	float pwr=pow(1.1,14+[audioPlayer averagePowerForChannel:0]);
	CGFloat max_pwr=1.0;
	if(pwr>max_pwr)
		pwr=max_pwr;
	CGFloat W=40+pwr*10;
	CGRect r2=CGRectMake(rect.size.width/2-W/2,rect.size.height/2-W/2, W, W);
    CGContextAddEllipseInRect(context, r2);
    CGContextSetFillColor(context, CGColorGetComponents([[UIColor redColor] CGColor]));
    CGContextFillPath(context);
} 

@end
