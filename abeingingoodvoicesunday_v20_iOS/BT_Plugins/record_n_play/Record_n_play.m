/*
 *	Copyright 2012, David Van Beveren
 *
 *	All rights reserved.
 *
 *	Redistribution and use in source and binary forms, with or without modification, are 
 *	permitted provided that the following conditions are met:
 *
 *	Redistributions of source code must retain the above copyright notice which includes the
 *	name(s) of the copyright holders. It must also retain this list of conditions and the 
 *	following disclaimer. 
 *
 *	Redistributions in binary form must reproduce the above copyright notice, this list 
 *	of conditions and the following disclaimer in the documentation and/or other materials 
 *	provided with the distribution. 
 *
 *	Neither the name of David Book, or buzztouch.com nor the names of its contributors 
 *	may be used to endorse or promote products derived from this software without specific 
 *	prior written permission.
 *
 *	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
 *	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
 *	IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
 *	INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT 
 *	NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
 *	PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
 *	WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
 *	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY 
 *	OF SUCH DAMAGE. 
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "JSON.h"
#import "BT_application.h"
#import "BT_strings.h"
#import "BT_viewUtilities.h"
#import "beingingoodvoicesunday_appDelegate.h"
#import "BT_item.h"
#import "BT_debugger.h"
#import "BT_viewControllerManager.h"
#import "Record_n_play.h"


@implementation Record_n_play
@synthesize actSpinner, btnStart, btnPlay, recordingImageView, timer;

//viewDidLoad
-(void)viewDidLoad{
	[BT_debugger showIt:self:@"viewDidLoad"];
	[super viewDidLoad];

	//put code here that adds UI controls to the screen. 
    
    //Start the toggle in true mode.
	toggle = YES;
	btnPlay.hidden = YES;
    
	//Instanciate an instance of the AVAudioSession object.
	AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    
	//Setup the audioSession for playback and record. 
	//We could just use record and then switch it to playback leter, but
	//since we are going to do both lets set it up once.
	[audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];
	
    //Activate the session
	[audioSession setActive:YES error: &error];
    
    //load the "recording" image...
    [self performSelector:(@selector(loadRecordingImage)) withObject:nil afterDelay:0.3];


}

//view will appear
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[BT_debugger showIt:self:@"viewWillAppear"];
	
	//flag this as the current screen
	beingingoodvoicesunday_appDelegate *appDelegate = (beingingoodvoicesunday_appDelegate *)[[UIApplication sharedApplication] delegate];
	appDelegate.rootApp.currentScreenData = self.screenData;
	
	//setup navigation bar and background
	[BT_viewUtilities configureBackgroundAndNavBar:self:[self screenData]];

	
}

//loadRecordingImage
-(void)loadRecordingImage{
	[BT_debugger showIt:self:@"loadRecordingImage"];
    
    UIImage *recordImage = [UIImage imageNamed:@"rnp_recording.png"];
    
    //if an image set in the json...
    NSString *tmpImageFile = [BT_strings getJsonPropertyValue:self.screenData.jsonVars:@"recordingImage":@"rnp_recording.png"];
      
    if([tmpImageFile length] > 3){
        if([tmpImageFile rangeOfString:@"http://"].location == NSNotFound){
            
            //use image from project...
            recordImage = [UIImage imageNamed:tmpImageFile];
            
        }else{
            
            //use image from url...
            recordImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tmpImageFile]]];
        }
    }
    
    //set image to begin...
    [recordingImageView setImage:recordImage];
    
    
    
}

//start_button_pressed...
-(IBAction)start_button_pressed{
    
    
    if(toggle)
	{
		toggle = NO;
		[actSpinner startAnimating];
		[btnStart setTitle:@"Stop Recording" forState: UIControlStateNormal ];	
		btnPlay.enabled = toggle;
		btnPlay.hidden = !toggle;
		
		//Begin the recording session.
		//Error handling removed.  Please add to your own code.
        
		//Setup the dictionary object with all the recording settings that this 
		//Recording sessoin will use
		//Its not clear to me which of these are required and which are the bare minimum.
		//This is a good resource: http://www.totodotnet.net/tag/avaudiorecorder/
		NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];
		[recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
		[recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey]; 
		[recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
		
		//Now that we have our settings we are going to instanciate an instance of our recorder instance.
		//Generate a temp file for use by the recording.
		//This sample was one I found online and seems to be a good choice for making a tmp file that
		//will not overwrite an existing one.
		
        //I know this is a mess of collapsed things into 1 call.  I can break it out if need be.
		recordedTmpFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"caf"]]];
		NSLog(@"Using File called: %@",recordedTmpFile);
        
		//Setup the recorder to use this file and record to it.
		recorder = [[ AVAudioRecorder alloc] initWithURL:recordedTmpFile settings:recordSetting error:&error];
		
        //Use the recorder to start the recording.
		//Im not sure why we set the delegate to self yet.  
		//Found this in antother example, but Im fuzzy on this still.
		[recorder setDelegate:self];
		
        //We call this to start the recording process and initialize
		//the subsstems so that when we actually say "record" it starts right away.
		[recorder prepareToRecord];
		
        //Start the actual Recording
		[recorder record];
		//There is an optional method for doing the recording for a limited time see 
		//[recorder recordForDuration:(NSTimeInterval) 10]
		
        //animate the recording graphic...
        timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(rotateImage) userInfo:nil repeats:YES];

        
	}else{
        
		toggle = YES;
		[actSpinner stopAnimating];
		[btnStart setTitle:@"Start Recording" forState:UIControlStateNormal ];
		btnPlay.enabled = toggle;
		btnPlay.hidden = !toggle;
		
		NSLog(@"Using File called: %@",recordedTmpFile);
        
		//Stop the recorder.
		[recorder stop];
        
        //stop the recording graphic animation....
        [timer invalidate];
        
	}
}

//didReceiveMemoryWarning...
-(void)didReceiveMemoryWarning{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


//play_button_pressed...
-(IBAction)play_button_pressed{
    
	//The play button was pressed... 
	//Setup the AVAudioPlayer to play the file that we just recorded.
	AVAudioPlayer * avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:recordedTmpFile error:&error];
	[avPlayer prepareToPlay];
	[avPlayer play];
	
}


//viewDidUnload...
-(void)viewDidUnload{
    
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	//Clean up the temp file.
	NSFileManager * fm = [NSFileManager defaultManager];
	[fm removeItemAtPath:[recordedTmpFile path] error:&error];
	//Call the dealloc on the remaining objects.
	[recorder dealloc];
	recorder = nil;
	recordedTmpFile = nil;
}


//audioRecorderDidFinishRecording...
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
	[BT_debugger showIt:self:@"audioRecorderDidFinishRecording"];
    
    //do something with the finished recording...
    
}

//audioRecorderEncodeErrorDidOccur
-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
	[BT_debugger showIt:self:@"audioRecorderEncodeErrorDidOccur"];
    
    //do something with the erorr message here...
    
    
}

//rotates image...
-(void)rotateImage{
    
    CATransform3D rotationTransform = CATransform3DMakeRotation(1.0f * M_PI, 0, 0, 1.0);
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];

    rotationAnimation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    rotationAnimation.duration = 0.75;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 2;

    [recordingImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

}

//dealloc
-(void)dealloc {
    [super dealloc];
    
    [actSpinner release];
    [btnStart release];
    [btnPlay release];
    [recordingImageView release];
    [timer release];
    

}


@end







