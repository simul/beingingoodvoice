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


// Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
/*	CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetFillColorWithColor( context, [UIColor blueColor].CGColor );
	CGRect subrect=rect;
	subrect.size.height=20;
    CGContextFillRect( context, subrect );
    // Drawing code
	
	
	CGMutablePathRef path = CGPathCreateMutable();
	
	CGFloat mid_x=rect.size.width/2;
	CGFloat top_y=20.f;
	// Add the outer arc to the path (as if you wanted to fill the entire circle)
	CGPathMoveToPoint(path,NULL,mid_x,top_y);
	CGPathAddArc(path, ...);
	CGPathCloseSubpath(path);
	
	// Add the inner arc to the path (later used to substract the inner area)
	CGPathMoveToPoint(path, ...);
	CGPathAddArc(path, ...);
	CGPathCloseSubpath(path);
	
	// Add the path to the context
	CGContextAddPath(context, path);
	
	// Fill the path using the even-odd fill rule
	CGContextEOFillPath(context);*/
} 

@end
